module mem_unit
import rv32i_types::*;
(
    input logic         clk,
    input logic         rst,
    // TODO: add ports needed to operate the memory instruction

    input rs_t          mem_next,
    input logic         issue_valid,

    // Comes from commit logic
    input logic         taking_from_mem, // TODO: needs commit implemented

    // Tell issue station unit is ready for new instruction
    output logic        mem_ready,

    // outputs to the commit stage to handle common data bus muxing
    output cdb_t        mem_cdb,

    // inputs and outputs from the bmem
    output logic        [31:0]  bmem_addr,
    output logic        [3:0]   bmem_rmask,
    output logic        [3:0]   bmem_wmask,
    output logic        [31:0]  bmem_wdata,
    input  logic        [255:0] bmem_rdata,
    input  logic                bmem_resp,

    // rvfi monitor outputs for mem specific signals
    output rvfi_mem_t          rvfi_mem_info,
    input logic                deq_req
);

    // instr to be executed and a corresponding logic to tell if it's valid
    rs_t                mem_pkt_fu;
    logic               issue_valid_reg;

    // internal signals
    logic               load_not_store;
    logic  [31:0]       address_start;
    logic  [31:0]       address;
    logic               got_response;
    logic [31:0]        word_rdata;
    logic [31:0]        masked_rdata;
    logic [31:0]        masked_rdata_reg;

    // rvfi memory info inputs to the fifo and dummy enq and deq req signals
    logic               enq_ready;
    logic               deq_ready;
    rvfi_mem_t          rvfi_mem_info_in;

    assign load_not_store = |mem_pkt_fu.r_mask; //if r_mask bits are all zero we must be storing
    assign address_start = (load_not_store) ? mem_pkt_fu.rs1_data + mem_pkt_fu.rs2_data : mem_pkt_fu.rs1_data + mem_pkt_fu.store_imm;
    assign address = {address_start[31:2], 2'b00};
    assign word_rdata = bmem_rdata[(address[4:2]*32)+:32]; 

    assign rvfi_mem_info_in.rvfi_mem_addr = address;
    assign rvfi_mem_info_in.rvfi_mem_rmask = mem_pkt_fu.r_mask << address_start[1:0];
    assign rvfi_mem_info_in.rvfi_mem_wmask = mem_pkt_fu.w_mask << address_start[1:0];
    assign rvfi_mem_info_in.rvfi_mem_rdata = masked_rdata << address_start[1:0]*8;
    assign rvfi_mem_info_in.rvfi_mem_wdata = bmem_wdata;

    fifo #(.WIDTH($bits(rvfi_mem_info)), .DEPTH(4)) mem_info_fifo //TODO: it is possible that the depth here isn't large enough
    (
        .clk(clk),
        .rst(rst),
        .enq_req(bmem_resp),
        .enq_data(rvfi_mem_info_in),
        .enq_ready(enq_ready),
        .deq_req(deq_req),
        .deq_data(rvfi_mem_info),
        .deq_ready(deq_ready)
    );

    // Register updates for the funtional unit and writeback stage
    always_ff @(posedge clk) begin
        if (rst) begin
            mem_pkt_fu <= '0;
            issue_valid_reg <= '0;
            got_response <= '0;
            masked_rdata_reg <= '0;
        end else begin
            mem_pkt_fu <= (issue_valid) ? mem_next : mem_pkt_fu; //we can only let issue happen if we commit from our writeback
            issue_valid_reg <= (issue_valid) ? '1 : (taking_from_mem) ? '0 : issue_valid_reg;
            got_response <= (bmem_resp) ? '1 : (issue_valid) ? '0 : got_response;
            masked_rdata_reg <= (bmem_resp) ? masked_rdata : masked_rdata_reg; 
        end
    end

    always_comb begin : common_data_bus_packaging
        mem_cdb.valid = (got_response && issue_valid_reg) ? valid_t'(1) : INVALID; //stall fu if we don't get a response back yet
        mem_cdb.rd_paddr = mem_pkt_fu.rd_paddr;
        mem_cdb.rd_data = masked_rdata_reg; // might be ignored if it's a store
        mem_cdb.rob_addr = mem_pkt_fu.rob_addr;
        mem_cdb.rs1_data = mem_pkt_fu.rs1_data;
        mem_cdb.rs2_data = mem_pkt_fu.rs2_data;
        mem_cdb.rd_valid = mem_pkt_fu.rd_valid;
        mem_cdb.br_result = '0; //mem instr can't cause a branch
    end

    // Logic for performing mem operations
    always_comb begin : MEM_COMB
        mem_ready = !issue_valid_reg;  
        bmem_wdata = 'x;


        case (mem_pkt_fu.mem_op)
            load_f3_lb : masked_rdata = {{24{word_rdata[7 +8 *address_start[1:0]]}}, word_rdata[8 *address_start[1:0] +: 8]};
            load_f3_lbu: masked_rdata = {{24{1'b0}}, word_rdata[8 *address_start[1:0] +: 8]};
            load_f3_lh : masked_rdata = {{16{word_rdata[15+16*address_start[1]]}}, word_rdata[16*address_start[1] +: 16]};
            load_f3_lhu: masked_rdata = {{16{1'b0}}, word_rdata[16*address_start[1] +: 16]};
            load_f3_lw : masked_rdata = word_rdata;
            default    : masked_rdata = '0;
        endcase
        case (mem_pkt_fu.mem_op)
            store_f3_sb: bmem_wdata[8  * address_start[1:0] +: 8 ] = mem_pkt_fu.rs2_data[7 :0];
            store_f3_sh: bmem_wdata[16 * address_start[1]   +: 16] = mem_pkt_fu.rs2_data[15:0];
            store_f3_sw: bmem_wdata = mem_pkt_fu.rs2_data;
            default    : bmem_wdata = 'x;
        endcase
        bmem_addr = address;
        bmem_rmask = (issue_valid_reg && !got_response) ? mem_pkt_fu.r_mask << address_start[1:0]: '0;
        bmem_wmask = (issue_valid_reg && !got_response) ? mem_pkt_fu.w_mask << address_start[1:0] : '0;
        // bmem_wdata = mem_pkt_fu.rs2_data; // will only matter for stores, masks will handle if not used
    end


endmodule : mem_unit
