module dis_stage
import rv32i_types::*;
(
    //input   logic                         clk,
    //input   logic                         rst,

    // Pipeline Registers
    input   instr_t                       id_rn_stage_reg,
    input   cdb_t               cdb,

    //Reservation Stations write    
    output logic [3:0]          rs_web,
    output rs_t                 rs_entry,

    //ROB write
    input logic [ROB_ADDR_WIDTH-1:0]   cur_rob_addr,
    input logic                 rob_full,
    output rob_t                rob_entry,

    input prf_t                 rs1_phys_entry,
    input prf_t                 rs2_phys_entry,
    
    //singlas from res station to indicate full, can change imlpementation
    input  logic                arith_enq_ready,
    input  logic                mem_enq_ready,
    input  logic                br_enq_ready,
    input  logic                mul_div_enq_ready
);


//logic to determine what functional unit the instruction should be dispatched to
//rs_web structure is tentative based on functional unit implementation
always_comb begin
    rs_web = 4'b0000;
    if (!rob_full && id_rn_stage_reg.valid) begin
        case (id_rn_stage_reg.funct_unit) 
            ARITH_UNIT : begin
                if (arith_enq_ready)
                    rs_web = 4'b0001;     //ALU unit
            end
            MEM_UNIT :  begin
                if (mem_enq_ready)
                    rs_web = 4'b0010;     //MEM unit
            end                    
            BR_UNIT : begin
                if (br_enq_ready)
                    rs_web = 4'b0100;     //BR unit
            end
            MUL_DIV_UNIT : begin
                if(mul_div_enq_ready)
                    rs_web = 4'b1000;
            end
            default : begin
                rs_web = 4'b0000;
            end
        endcase
    end
end

//need to determine what instr packet should contain
always_comb begin : rs_pkt_assignment
    // Most recent data that can be forwarded
    if(!id_rn_stage_reg.rs1_ready && id_rn_stage_reg.rs1_data[PHYS_REG_ADDR_WIDTH-1:0] == cdb.rd_paddr && cdb.valid && cdb.rd_valid) begin
        rs_entry.rs1_ready = '1;
        rs_entry.rs1_data = cdb.rd_data;
    end
    // If dependecy is in FU or retiring stages then data will be in PRF
    else if (!id_rn_stage_reg.rs1_ready && rs1_phys_entry.valid) begin
        rs_entry.rs1_ready = '1;
        rs_entry.rs1_data = rs1_phys_entry.data;
    end
    // Take already valid arch data or wait for cdb with update in the RS
    else begin
        rs_entry.rs1_ready = id_rn_stage_reg.rs1_ready;
        rs_entry.rs1_data = id_rn_stage_reg.rs1_data;
    end

    if(!id_rn_stage_reg.rs2_ready && id_rn_stage_reg.rs2_data[PHYS_REG_ADDR_WIDTH-1:0] == cdb.rd_paddr && cdb.valid && cdb.rd_valid) begin
        rs_entry.rs2_ready = '1;
        rs_entry.rs2_data = cdb.rd_data;
    end
    else if (!id_rn_stage_reg.rs2_ready && rs2_phys_entry.valid) begin
        rs_entry.rs2_ready = '1;
        rs_entry.rs2_data = rs2_phys_entry.data;
    end
    else begin
        rs_entry.rs2_ready = id_rn_stage_reg.rs2_ready;
        rs_entry.rs2_data = id_rn_stage_reg.rs2_data;
    end

    rs_entry.rob_addr = cur_rob_addr;
    rs_entry.pc_wdata = id_rn_stage_reg.pc_wdata;
    rs_entry.rd_valid = id_rn_stage_reg.rd_valid;
    rs_entry.r_mask = id_rn_stage_reg.r_mask;
    rs_entry.w_mask = id_rn_stage_reg.w_mask;
    rs_entry.alu_op = id_rn_stage_reg.alu_op;
    rs_entry.mul_div_op = id_rn_stage_reg.funct3;
    rs_entry.branch_op = id_rn_stage_reg.funct3;
    rs_entry.mem_op = id_rn_stage_reg.funct3;
    rs_entry.rd_paddr = id_rn_stage_reg.rd_paddr;
    rs_entry.valid = id_rn_stage_reg.valid;
    rs_entry.store_imm = {{21{id_rn_stage_reg.instr[31]}}, id_rn_stage_reg.instr[30:25], id_rn_stage_reg.instr[11:7]};
end 


always_comb begin : rob_entry_assignment
    rob_entry.valid = id_rn_stage_reg.valid;
    rob_entry.status  = WAIT;
    rob_entry.op = id_rn_stage_reg.funct_unit;
    rob_entry.rd_paddr = id_rn_stage_reg.rd_paddr;
    rob_entry.rd_addr = id_rn_stage_reg.rd_addr;
    rob_entry.rs_info.rs1_data = id_rn_stage_reg.rs1_data;
    rob_entry.rs_info.rs2_data = id_rn_stage_reg.rs2_data;
    // Info used for rvfi, valid used for ROB
    rob_entry.instr_info.instr = id_rn_stage_reg.instr;
    rob_entry.instr_info.pc_rdata = id_rn_stage_reg.pc_rdata;
    rob_entry.instr_info.pc_wdata = id_rn_stage_reg.pc_wdata;
    rob_entry.instr_info.rs1_valid = id_rn_stage_reg.rs1_valid;
    rob_entry.instr_info.rs2_valid = id_rn_stage_reg.rs2_valid;
    rob_entry.instr_info.rd_valid = id_rn_stage_reg.rd_valid;
    // TODO branch not taken predictor for now
    // rob_entry.br_pred = NOT_TAKEN;
    rob_entry.br_pred = id_rn_stage_reg.br_pred;
end

endmodule
