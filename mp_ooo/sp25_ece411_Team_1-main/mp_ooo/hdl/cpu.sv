module cpu
import rv32i_types::*;
(
    input   logic               clk,
    input   logic               rst,

    output  logic   [31:0]      bmem_addr,
    output  logic               bmem_read,
    output  logic               bmem_write,
    output  logic   [63:0]      bmem_wdata,
    input   logic               bmem_ready,

    input   logic   [31:0]      bmem_raddr,
    input   logic   [63:0]      bmem_rdata,
    input   logic               bmem_rvalid
);
// Generally keep large module components in this cpu file for cross stage
// access

// Instruction Memory Interface
logic   [31:0]  imem_addr;
logic   [3:0]   imem_rmask;
logic   [255:0] imem_rdata;
logic   [31:0]  imem_wdata;
logic           imem_resp; 


// Stage Registers
instr_t if_id_stage_reg, if_id_stage_reg_next;
instr_t id_rn_stage_reg, id_rn_stage_reg_next;

rob_t rob_entry;
logic branch_miss;
logic branch_miss_pred;
logic [31:0] branch_target_rrf;
logic [31:0] branch_target;

//imem signal instantiations
logic [31:0] bmem_raddr_imem;
logic [63:0] bmem_rdata_imem;
logic        bmem_rvalid_imem;
logic [31:0] bmem_addr_imem;
logic        bmem_read_imem;
logic        bmem_write_imem;
logic [63:0] bmem_wdata_imem;
logic        bmem_ready_imem;

rob_t entry_to_retire;

// branch prediction signals
taken_t      br_pred;
logic [31:0] b_imm, j_imm; 
// taken_t      br_pred_ff;
logic [31:0] pc_fetch;  
logic        pc_fetch_valid;      

logic im_cache_stop_req;

cache_top im_cache_i(
    .clk(clk),
    .rst(rst),
    .ufp_addr(imem_addr),
    .ufp_rmask(imem_rmask),
    .ufp_wmask('0),
    .ufp_rdata(imem_rdata),
    .ufp_wdata('x),
    .ufp_resp(imem_resp),

    .dram_raddr(bmem_raddr_imem),
    .dram_rdata(bmem_rdata_imem),
    .dram_rvalid(bmem_rvalid_imem),
    .dram_addr(bmem_addr_imem),
    .dram_read(bmem_read_imem),
    .dram_write(bmem_write_imem),
    .dram_wdata(bmem_wdata_imem),
    .dram_ready(bmem_ready_imem),
    
    .stop_req(im_cache_stop_req)
);

// TODO handle stall
logic dispatch_stall;


logic free_list_enq_ready, free_list_deq_ready;
logic free_list_enq_enb, free_list_deq_enb;
logic [PHYS_REG_ADDR_WIDTH-1:0] free_list_rename_paddr;
logic [PHYS_REG_ADDR_WIDTH-1:0] free_list_retire_paddr;
logic free_list_near_empty;

fifo #(.WIDTH(PHYS_REG_ADDR_WIDTH), .DEPTH(NUM_PHYS_REGS), .CUSTOM(FREE_LIST)) free_list
(
    .clk(clk),
    .rst(rst | branch_miss),
    // TODO Add commit stage inputs when stage ready
    .enq_req(free_list_enq_enb),
    .enq_data(free_list_retire_paddr),
    .enq_ready(free_list_enq_ready),
    // ----------------------------
    .deq_req(free_list_deq_enb),
    .deq_data(free_list_rename_paddr),
    .deq_ready(free_list_deq_ready),
    .near_empty(free_list_near_empty)
);

// Rename Stage
logic       [4:0]               rename_rd_addr;     // Destination address for rename entry
rat_arf_t                       rename_entry;       // Entry from rename stage to write in RAT + ARF
logic                           rename_web;         // Write enable
// Source Register information
logic       [4:0]               rs1_addr;           // Source Register 1 Address to read from
rat_arf_t                       rs1_entry;          // RS1 entry from RAT + ARF
logic       [4:0]               rs2_addr;           // Source Register 2 Address to read from
rat_arf_t                       rs2_entry;          // RS2 entry from RAT + ARF
// Commit Stage
logic       [4:0]               commit_rd_addr;     // Destination Address to unmap
logic                           commit_web;         // Write Enable
logic [PHYS_REG_ADDR_WIDTH-1:0] commit_paddr;
rat_arf_t commit_entry;
logic commit_prf_web;
logic commit_arf_web;
rat_arf_t rat_entry_to_update;

logic [4:0] rs1_rat;
logic [4:0] rs2_rat;

assign rs1_rat = (dispatch_stall) ? id_rn_stage_reg_next.rs1_addr : rs1_addr;
assign rs2_rat = (dispatch_stall) ? id_rn_stage_reg_next.rs2_addr : rs2_addr;

rat_arf rat_arf_i
(
    .clk(clk),
    .rst(rst),
    .branch_miss(branch_miss),
    .rename_rd_addr(rename_rd_addr),
    .rename_entry(rename_entry),
    .rename_web(rename_web),
    .rs1_addr(rs1_rat),
    .rs1_entry(rs1_entry),
    .rs2_addr(rs2_rat),
    .rs2_entry(rs2_entry),
    .commit_rd_addr(commit_rd_addr),
    .commit_entry(commit_entry),
    .commit_web(commit_arf_web),
    // -------------------
    .head_entry_rd_addr(entry_to_retire.rd_addr),
    .rat_entry_to_update(rat_entry_to_update)
);

// Output for dispatch stage
prf_t rs1_phys_entry;
prf_t rs2_phys_entry;

// Common data bus for RS, PRF, and ROB
cdb_t cdb;

// Commit stage interaction

logic commit_addr_stay_renamed;
logic retire_deq_req;

logic [PHYS_REG_ADDR_WIDTH-1:0] rs1_paddr_prf;
logic [PHYS_REG_ADDR_WIDTH-1:0] rs2_paddr_prf;

assign rs1_paddr_prf = rs1_entry.paddr;
assign rs2_paddr_prf = (id_rn_stage_reg_next.rs2_valid) ? rs2_entry.paddr : rs1_entry.paddr;

logic [PHYS_REG_ADDR_WIDTH-1:0] retire_prf_paddr;
logic retire_prf_web;

prf prf_i 
(
    .clk(clk),
    .rst(rst),
    // Decode Rename Stage 
    .rs1_paddr(rs1_paddr_prf),   
    .rs2_paddr(rs2_paddr_prf),
    // Dispatch State
    .rs1_entry(rs1_phys_entry),
    .rs2_entry(rs2_phys_entry),
    // Writeback
    .wb_rd_paddr(cdb.rd_paddr),                
    .wb_data(cdb.rd_data),
    .wb_web(cdb.rd_valid & cdb.valid),
    // Commit Stage
    .commit_paddr(commit_paddr),
    .commit_entry(commit_entry),
    .branch_miss(branch_miss),
    .commit_addr_stay_renamed(commit_addr_stay_renamed),
    .retire_prf_web(retire_prf_web),
    .retire_prf_paddr(retire_prf_paddr)

);

rob_t rvfi_rob_entry;
logic rob_full;
logic rob_empty;

rrf rrf_i 
(
    .clk(clk),
    .rst(rst),
    //commited rob entry
    .head_entry(entry_to_retire),
    .retire_deq_req(retire_deq_req),
    .rob_empty(rob_empty),
    .branch_miss(branch_miss),
    .branch_target(branch_target_rrf),
    //write to free list
    .freed_paddr(free_list_retire_paddr),
    .free_list_enq_enb(free_list_enq_enb),
    .commit_paddr(commit_paddr),
    .commit_rd_addr(commit_rd_addr),
    .commit_arf_web(commit_arf_web),
    .rvfi_rob_entry(rvfi_rob_entry),
    .commit_addr_stay_renamed(commit_addr_stay_renamed),
    .retire_prf_web(retire_prf_web),
    .retire_prf_paddr(retire_prf_paddr),
    .rat_entry_to_update(rat_entry_to_update)
);



// Dispatch singals for making reservation station entry
rs_t dispatch_rs_entry;
logic [3:0] rs_web;
logic [3:0] rs_deq;

logic deq_req;
rs_t deq_data;
logic deq_ready;
// Reservation Signals, full for dispatch, empty for issue
logic arith_enq_ready;
logic mem_enq_ready;
logic br_enq_ready;
logic mul_div_enq_ready;

logic rs_alu_nonempty;
logic rs_mem_nonempty;
logic rs_br_nonempty;
logic rs_mul_div_nonempty;

// rs packet for functional unit
rs_t arith_next;
rs_t mem_next;
rs_t br_next;
rs_t mul_div_next;

// Functional units signals for indicating ready for new packet
logic arith_ready;
logic mem_ready;
logic br_ready;
logic mul_div_ready;

logic arith_near_full;
logic mem_near_full;
logic br_near_full;
logic mul_div_near_full;

rs_fifo #(.WIDTH($bits(rs_t)), .DEPTH(RS_ARITH_DEPTH)) rs_arith(
    .clk(clk),
    .rst(rst | branch_miss),
    .cdb(cdb),
    .enq_req(rs_web[0]),
    .enq_data(dispatch_rs_entry),
    .enq_ready(arith_enq_ready),
    .deq_req(rs_deq[0]),
    .deq_data(arith_next),
    .deq_ready(rs_alu_nonempty),
    .near_full(arith_near_full)
);
rs_fifo #(.WIDTH($bits(rs_t)), .DEPTH(RS_MEM_DEPTH)) rs_mem(
    .clk(clk),
    .rst(rst | branch_miss),
    .cdb(cdb),
    .enq_req(rs_web[1]),
    .enq_data(dispatch_rs_entry),
    .enq_ready(mem_enq_ready),
    .deq_req(rs_deq[1]),
    .deq_data(mem_next),
    .deq_ready(rs_mem_nonempty),
    .near_full(mem_near_full)
);
rs_fifo #(.WIDTH($bits(rs_t)), .DEPTH(RS_BR_DEPTH)) rs_br(
    .clk(clk),
    .rst(rst | branch_miss),
    .cdb(cdb),
    .enq_req(rs_web[2]),
    .enq_data(dispatch_rs_entry),
    .enq_ready(br_enq_ready),
    .deq_req(rs_deq[2]),
    .deq_data(br_next),
    .deq_ready(rs_br_nonempty),
    .near_full(br_near_full)
);
rs_fifo #(.WIDTH($bits(rs_t)), .DEPTH(RS_MUL_DEPTH)) rs_mul_div(
    .clk(clk),
    .rst(rst | branch_miss),
    .cdb(cdb),
    .enq_req(rs_web[3]),
    .enq_data(dispatch_rs_entry),
    .enq_ready(mul_div_enq_ready),
    .deq_req(rs_deq[3]),
    .deq_data(mul_div_next),
    .deq_ready(rs_mul_div_nonempty),
    .near_full(mul_div_near_full)
);

//functional unit signals
logic taking_from_alu, taking_from_mem, taking_from_br, taking_from_mul_div; 
cdb_t arith_cdb, mem_cdb, br_cdb, mul_div_cdb;
logic [3:0] issue_valid;        // Signal to tell functional unit to take unit next pkt
// modifications to alu are being done so it handles all parts of the functional unit (execution and writeback)
alu_unit alu_unit_i
(
    .clk(clk),
    .rst(rst | branch_miss),
    .arith_next(arith_next),
    .issue_valid(issue_valid[0]),

    .taking_from_alu(taking_from_alu),

    .arith_ready(arith_ready),
    .arith_cdb(arith_cdb)
);

logic [31:0] dmem_addr;
logic [3:0] dmem_rmask, dmem_wmask;
logic [31:0] dmem_wdata;
logic [255:0] dmem_rdata;
logic dmem_resp;
rvfi_mem_t          rvfi_mem_info;

logic issue_load, issue_store, sq_enq_ready, lq_enq_ready;;
logic [ROB_ADDR_WIDTH-1:0] rob_head;

mem_unit_lsq mem_unit_i
(
    .clk(clk),
    .rst(rst),
    .mem_next(mem_next),
    .issue_valid(issue_valid[1]),
    .taking_from_mem(taking_from_mem),
    .mem_cdb(mem_cdb),
    //signals to mem
    .bmem_addr(dmem_addr),
    .bmem_rmask(dmem_rmask),
    .bmem_wmask(dmem_wmask),
    .bmem_wdata(dmem_wdata),
    .bmem_rdata(dmem_rdata),
    .bmem_resp(dmem_resp),
    .rvfi_mem_info(rvfi_mem_info),
    .deq_req(rvfi_rob_entry.op == MEM_UNIT),
    .rvfi_load(rvfi_rob_entry.instr_info.instr[6:0] == 7'b0000011),
    .sq_enq_ready(sq_enq_ready),
    .lq_enq_ready(lq_enq_ready),
    .issue_store(issue_store),
    .issue_load(issue_load),
    .rob_head(rob_head),
    .branch_miss(branch_miss)
);



br_unit br_unit_i
(
    .clk(clk),
    .rst(rst | branch_miss),
    .br_next(br_next),
    .issue_valid(issue_valid[2]),
    .taking_from_br(taking_from_br),
    .br_ready(br_ready),
    .br_cdb(br_cdb)
);

mul_div_unit mul_div_unit_i
(
    .clk(clk),
    .rst(rst | branch_miss),
    .issue_valid(issue_valid[3]),
    .mul_div_next(mul_div_next),
    .mul_div_ready(mul_div_ready),
    .mul_div_result(mul_div_cdb),
    .taking_from_mul_div(taking_from_mul_div)
);

if_stage if_stage_i(
    .clk(clk),
    .rst(rst),
    .imem_rdata(imem_rdata),
    .imem_resp(imem_resp),
    .imem_addr(imem_addr),
    .imem_rmask(imem_rmask),
    .branch_target(branch_target),
    .branch_miss(branch_miss_pred),
    .if_id_stage_reg_next(if_id_stage_reg_next),
    .rs1_addr(rs1_addr),
    .rs2_addr(rs2_addr),
    .dis_stall(dispatch_stall),
    .br_pred(br_pred),
    .pc_reg_out(pc_fetch),
    .pc_reg_out_valid(pc_fetch_valid),
    .im_cache_stop_req(im_cache_stop_req)
);
id_rn_stage id_rn_stage
(
    .free_list_rename_paddr(free_list_rename_paddr),
    .free_list_deq_enb(free_list_deq_enb),
    .free_list_deq_ready(free_list_deq_ready),
    .if_id_stage_reg(if_id_stage_reg),
    .id_rn_stage_reg_next(id_rn_stage_reg_next),
    .rs1_entry(rs1_entry),
    .rs2_entry(rs2_entry),
    .rename_web(rename_web),
    .rename_entry(rename_entry),
    .rename_rd_addr(rename_rd_addr)
);

// ROB signals
logic [ROB_ADDR_WIDTH-1:0] allocated_rob_addr;

// Writeback stage interaction
logic wb_ready_to_commit;
logic [ROB_ADDR_WIDTH-1:0] wb_rob_addr;
logic rob_near_full;

rob rob_i
(
   .clk(clk),
   .rst(rst | branch_miss),
   .dispatch_entry(rob_entry),
   .cur_rob_addr(allocated_rob_addr),
   .wb_ready_to_commit(wb_ready_to_commit),
   .wb_rob_addr(wb_rob_addr),
   .head_entry(entry_to_retire),
   .retire_deq_req(retire_deq_req),
   .rob_full(rob_full),
   .rob_empty(rob_empty),
   .cdb_sel(cdb),
   .rob_near_full(rob_near_full),
   .rob_head_out(rob_head)
);


dis_stage dis_stage
(
    // Decode/Rename data
    .id_rn_stage_reg(id_rn_stage_reg),

    //Reservation Stations write
    .rs_web(rs_web),
    .rs_entry(dispatch_rs_entry),
    .cdb(cdb),

    //ROB write
    .cur_rob_addr(allocated_rob_addr),
    .rob_full(rob_full),
    .rob_entry(rob_entry),

    // PRF outputs
    .rs1_phys_entry(rs1_phys_entry),
    .rs2_phys_entry(rs2_phys_entry),
    
    // Enqueue ready signals
    .arith_enq_ready(arith_enq_ready),
    .mem_enq_ready(mem_enq_ready),
    .br_enq_ready(br_enq_ready),
    .mul_div_enq_ready(mul_div_enq_ready)
);

commit_stage commit_stage
(
    .arith_cdb(arith_cdb),
    .mem_cdb(mem_cdb),
    .br_cdb(br_cdb),
    .mul_div_cdb(mul_div_cdb),

    .selected_cdb(cdb),
    .rob_head_op(entry_to_retire.op),
    .wb_ready_to_commit(wb_ready_to_commit),
    .wb_rob_addr(wb_rob_addr),

    .taking_from_alu(taking_from_alu),
    .taking_from_mem(taking_from_mem),
    .taking_from_br(taking_from_br),
    .taking_from_mul_div(taking_from_mul_div)
);

iss_stage iss_stage 
(
	.arith_next(arith_next),
	.mem_next(mem_next),
	.br_next(br_next),
	.mul_div_next(mul_div_next),
	.rs_alu_nonempty(rs_alu_nonempty),
	.rs_mem_nonempty(rs_mem_nonempty),
	.rs_br_nonempty(rs_br_nonempty),
	.rs_mul_div_nonempty(rs_mul_div_nonempty),
	.arith_ready(arith_ready),
	.br_ready(br_ready),
	.mul_div_ready(mul_div_ready),
	.rs_deq(rs_deq),
	.issue_valid(issue_valid),
    .branch_miss(branch_miss),
    .sq_enq_ready(sq_enq_ready),
    .lq_enq_ready(lq_enq_ready),
    .issue_load(issue_load),
    .issue_store(issue_store)
); 


//dmem signal instantiations
logic [31:0] bmem_raddr_dmem;
logic [63:0] bmem_rdata_dmem;
logic        bmem_rvalid_dmem;
logic [31:0] bmem_addr_dmem;
logic        bmem_read_dmem;
logic        bmem_write_dmem;
logic [63:0] bmem_wdata_dmem;
logic        bmem_ready_dmem;

logic        dmem_cache_stop_req;

assign dmem_cache_stop_req = branch_miss; // Not used (yet)

cache_top #(.WAY(2), .SETS(32)) dmem_cache_i(
    .clk(clk),
    .rst(rst),
    .ufp_addr(dmem_addr),
    .ufp_rmask(dmem_rmask),
    .ufp_wmask(dmem_wmask),
    .ufp_rdata(dmem_rdata),
    .ufp_wdata(dmem_wdata),
    .ufp_resp(dmem_resp),

    .dram_raddr(bmem_raddr_dmem),
    .dram_rdata(bmem_rdata_dmem),
    .dram_rvalid(bmem_rvalid_dmem),
    .dram_addr(bmem_addr_dmem),
    .dram_read(bmem_read_dmem),
    .dram_write(bmem_write_dmem),
    .dram_wdata(bmem_wdata_dmem),
    .dram_ready(bmem_ready_dmem),
    .stop_req(dmem_cache_stop_req)
);

mem_arbiter arb_inst (
    .clk(clk),
    .rst(rst),

    // IMEM cache ports
    .bmem_addr_imem(bmem_addr_imem),
    .bmem_read_imem(bmem_read_imem),
    .bmem_write_imem(bmem_write_imem),
    .bmem_wdata_imem(bmem_wdata_imem),
    .bmem_ready_imem(bmem_ready_imem),
    .bmem_rdata_imem(bmem_rdata_imem),
    .bmem_rvalid_imem(bmem_rvalid_imem),
    .bmem_raddr_imem(bmem_raddr_imem),

    // DMEM cache ports
    .bmem_addr_dmem(bmem_addr_dmem),
    .bmem_read_dmem(bmem_read_dmem),
    .bmem_write_dmem(bmem_write_dmem),
    .bmem_wdata_dmem(bmem_wdata_dmem),
    .bmem_ready_dmem(bmem_ready_dmem),
    .bmem_rdata_dmem(bmem_rdata_dmem),
    .bmem_rvalid_dmem(bmem_rvalid_dmem),
    .bmem_raddr_dmem(bmem_raddr_dmem),

    // Shared memory interface
    .bmem_addr(bmem_addr),
    .bmem_read(bmem_read),
    .bmem_write(bmem_write),
    .bmem_wdata(bmem_wdata),
    .bmem_ready(bmem_ready),
    .bmem_raddr(bmem_raddr),
    .bmem_rdata(bmem_rdata),
    .bmem_rvalid(bmem_rvalid)
);

gshare #(.GHR_WIDTH(10)) gshare_im (
    .clk(clk),
    .rst(rst),

    .pc_fetch(if_id_stage_reg_next.pc_rdata),
    .pc_fetch_valid(if_id_stage_reg_next.valid),
    .pc_retire(entry_to_retire.instr_info.pc_rdata),
    .head_entry(entry_to_retire),
    .br_pred(br_pred)
);

// gshare_attempt #(.GHR_WIDTH(9)) gshare_sram (
//     .clk(clk),
//     .rst(rst),

//     .pc_fetch(pc_fetch),
//     .pc_fetch_valid(pc_fetch_valid),
//     .pc_retire(entry_to_retire.instr_info.pc_rdata),
//     .head_entry(entry_to_retire),
//     .br_pred(br_pred)
// );

// Control Unit Logic (may need its own module if big)
always_ff @(posedge clk) begin : control_unit
    if (rst | branch_miss) begin
        if_id_stage_reg.valid <= INVALID;
        id_rn_stage_reg.valid <= INVALID;
    end
    else begin
        if_id_stage_reg <= if_id_stage_reg_next;
        id_rn_stage_reg <= id_rn_stage_reg_next;
    end
end

// TODO dispatch_stall signal generation
// Approach if RSs or ROB are about to fill need to tell fetch stage to wait
always_comb begin : control_logic
    dispatch_stall = '0;
    // ROB approaching full need to hold off fetch stage
    if ( (rob_near_full || arith_near_full || mem_near_full || br_near_full || mul_div_near_full || free_list_near_empty) )
        dispatch_stall = '1; 

end

assign b_imm  = {{20{if_id_stage_reg_next.instr[31]}}, if_id_stage_reg_next.instr[7], if_id_stage_reg_next.instr[30:25], if_id_stage_reg_next.instr[11:8], 1'b0};
assign j_imm  = {{12{if_id_stage_reg_next.instr[31]}}, if_id_stage_reg_next.instr[19:12], if_id_stage_reg_next.instr[20], if_id_stage_reg_next.instr[30:21], 1'b0};

always_comb begin : branch_pred_miss_handler
    if (branch_miss) begin
        branch_target = branch_target_rrf;
        branch_miss_pred = branch_miss;
    end else begin
        case (if_id_stage_reg_next.instr[6:0])
            op_b_jal  : begin 
                branch_target = if_id_stage_reg_next.pc_rdata + j_imm;
                branch_miss_pred = (if_id_stage_reg_next.valid) ? TAKEN : br_pred; //its a jump so we have to take it
            end
            op_b_jalr : begin
                branch_target = if_id_stage_reg_next.pc_rdata + j_imm; //uhh, i guess well just NOT_TAKEN, value is ignored (uses rs1 data for addr )
                branch_miss_pred = NOT_TAKEN;
            end
            op_b_br   : begin
                branch_target = if_id_stage_reg_next.pc_rdata + b_imm;
                branch_miss_pred = br_pred; //heres where the magic happens
            end
            default   : begin
                branch_target = if_id_stage_reg_next.pc_rdata + j_imm; //not a branch or jump so ignore
                branch_miss_pred = NOT_TAKEN;
            end
        endcase 
    end
end


// RVFI monitor interface
logic rvfi_mon_valid;
logic [63:0] rvfi_mon_order;
logic [31:0] rvfi_mon_inst;
logic [4:0]  rvfi_mon_rs1_addr;
logic [4:0]  rvfi_mon_rs2_addr;
logic [31:0] rvfi_mon_rs1_rdata;
logic [31:0] rvfi_mon_rs2_rdata;
logic [4:0]  rvfi_mon_rd_addr;
logic [31:0] rvfi_mon_rd_wdata;
logic [31:0] rvfi_mon_pc_rdata;
logic [31:0] rvfi_mon_pc_wdata;
logic [31:0] rvfi_mon_mem_addr;
logic [3:0]  rvfi_mon_mem_rmask;
logic [3:0]  rvfi_mon_mem_wmask;
logic [31:0] rvfi_mon_mem_rdata;
logic [31:0] rvfi_mon_mem_wdata;

logic [63:0] order;
always_ff @(posedge clk) begin
    if (rst)
        order <= '0;
    else begin
        order <= (rvfi_rob_entry.status == DONE) ? order + 'd1 : order;
    end
end

assign rvfi_mon_valid      = rvfi_rob_entry.status && rvfi_rob_entry.valid;
assign rvfi_mon_order      = order;
assign rvfi_mon_inst       = rvfi_rob_entry.instr_info.instr;
assign rvfi_mon_rs1_addr   = (rvfi_rob_entry.instr_info.rs1_valid) ? rvfi_rob_entry.instr_info.instr[19:15] : '0;
assign rvfi_mon_rs2_addr   = (rvfi_rob_entry.instr_info.rs2_valid) ? rvfi_rob_entry.instr_info.instr[24:20] : '0;
assign rvfi_mon_rs1_rdata  = (rvfi_rob_entry.instr_info.rs1_valid) ? rvfi_rob_entry.rs_info.rs1_data : '0;
assign rvfi_mon_rs2_rdata  = (rvfi_rob_entry.instr_info.rs2_valid) ? rvfi_rob_entry.rs_info.rs2_data : '0;
assign rvfi_mon_rd_addr    = (rvfi_rob_entry.instr_info.rd_valid) ? rvfi_rob_entry.instr_info.instr[11:7] : '0;
assign rvfi_mon_rd_wdata   = (rvfi_rob_entry.instr_info.rd_valid && rvfi_rob_entry.instr_info.instr[11:7] != '0) ? commit_entry.data : '0;
assign rvfi_mon_pc_rdata   = rvfi_rob_entry.instr_info.pc_rdata;
assign rvfi_mon_pc_wdata   = rvfi_rob_entry.instr_info.pc_wdata;
assign rvfi_mon_mem_addr   = (rvfi_rob_entry.op == MEM_UNIT) ? rvfi_mem_info.rvfi_mem_addr  : '0;
assign rvfi_mon_mem_rmask  = (rvfi_rob_entry.op == MEM_UNIT) ? rvfi_mem_info.rvfi_mem_rmask : '0;
assign rvfi_mon_mem_wmask  = (rvfi_rob_entry.op == MEM_UNIT) ? rvfi_mem_info.rvfi_mem_wmask : '0;
assign rvfi_mon_mem_rdata  = (rvfi_rob_entry.op == MEM_UNIT) ? rvfi_mem_info.rvfi_mem_rdata : '0;
assign rvfi_mon_mem_wdata  = (rvfi_rob_entry.op == MEM_UNIT) ? rvfi_mem_info.rvfi_mem_wdata : '0;

endmodule : cpu
