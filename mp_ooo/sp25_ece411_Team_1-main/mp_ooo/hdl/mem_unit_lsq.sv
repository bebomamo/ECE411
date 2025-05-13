module mem_unit_lsq
import rv32i_types::*;
(
    input logic         clk,
    input logic         rst,
    // TODO: add ports needed to operate the memory instruction

    input rs_t          mem_next,
    input logic         issue_valid,

    // Comes from commit logic
    input logic         taking_from_mem, // TODO: needs commit implemented


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
    input logic deq_req,

    //split lsq signals
    output logic sq_enq_ready,
    output logic lq_enq_ready,
    input logic issue_store,
    input logic issue_load,
    input logic [ROB_ADDR_WIDTH-1:0] rob_head,
    input logic rvfi_load,
    input logic branch_miss
    );

    // instr to be executed and a corresponding logic to tell if it's valid
    lsq_t                mem_pkt_fu;
    logic               issue_valid_reg;
    logic issue_valid_temp;
    assign issue_valid_temp = issue_valid;
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
    logic [ROB_ADDR_WIDTH-1:0] rvfi_rob_addr;


    logic lq_deq_ready, sq_deq_ready, deq_load, deq_store;
    logic deq_data_ready, sq_head_ready;
    lsq_t load_in, load_out;
    lsq_t store_in, store_out;
    logic [ROB_ADDR_WIDTH-1:0] load_head_age;

    logic [SQ_ADDR_WIDTH:0] store_count;                    //hard coded size
    logic [ROB_ADDR_WIDTH-1:0] store_head_age;
    logic [ROB_ADDR_WIDTH-1:0] store_tail_age;

    //hard coded sizes
    logic [SQ_DEPTH-1:0]                        store_valid;
    logic [SQ_DEPTH-1:0][31:0]                  store_address;
    logic [SQ_DEPTH-1:0][ROB_ADDR_WIDTH-1:0]    store_rob_addr;

    load_queue #(.WIDTH($bits(lsq_t)), .DEPTH(SQ_DEPTH)) lq_i (
        .clk(clk),
        .rst(rst | branch_miss),
        .enq_req(issue_load),
        .enq_data(load_in),
        .enq_ready(lq_enq_ready),
        .deq_req(deq_load),
        .deq_data(load_out),
        .deq_ready(lq_deq_ready),
        .rob_head(rob_head),
        .store_head_age(store_head_age),
        .store_count(store_count),
        .deq_data_ready(deq_data_ready),
        .store_tail_age(store_tail_age),
        .store_valid(store_valid),
        .store_address(store_address),
        .store_rob_addr(store_rob_addr)
    );

    store_queue #(.WIDTH($bits(lsq_t)), .DEPTH(SQ_DEPTH)) sq_i (
        .clk(clk),
        .rst(rst | branch_miss),
        .enq_req(issue_store),
        .enq_data(store_in),
        .enq_ready(sq_enq_ready),
        .deq_req(deq_store),
        .deq_data(store_out),
        .deq_ready(sq_deq_ready),
        .rob_head(rob_head),
        .store_count(store_count),
        .store_head_age(store_head_age),
        .store_tail_age(store_tail_age),
        .store_valid(store_valid),
        .store_address(store_address),
        .store_rob_addr(store_rob_addr)
    );


    assign load_not_store = |mem_next.r_mask; //if r_mask bits are all zero we must be storing
    assign address_start = (load_not_store) ? mem_next.rs1_data + mem_next.rs2_data : mem_next.rs1_data + mem_next.store_imm;
    assign address = {address_start[31:2], 2'b00};

    assign sq_head_ready = (store_out.rob_addr == rob_head);
    assign deq_store = sq_head_ready && sq_deq_ready && !issue_valid_reg;
    assign deq_load = deq_data_ready && lq_deq_ready && !issue_valid_reg && !deq_store;


    always_comb begin
        //load assignment
        load_in.address = address;
        load_in.r_mask = mem_next.r_mask;
        load_in.w_mask = '0;
        load_in.rd_paddr = mem_next.rd_paddr;
        load_in.rob_addr = mem_next.rob_addr;
        load_in.valid = mem_next.valid;
        load_in.address_start = address_start;
        load_in.rs1_data = mem_next.rs1_data;
        load_in.rs2_data = mem_next.rs2_data;
        load_in.rd_valid = mem_next.rd_valid;
        load_in.mem_op = mem_next.mem_op;
        load_in.load_not_store = load_not_store;

        //store assignment
        store_in.address   = address;
        store_in.r_mask = '0;
        store_in.w_mask    = mem_next.w_mask;
        store_in.rd_paddr = '0;
        store_in.rob_addr = mem_next.rob_addr;
        store_in.valid     = mem_next.valid;
        store_in.address_start = address_start;
        store_in.rs1_data = mem_next.rs1_data;
        store_in.rs2_data = mem_next.rs2_data;
        store_in.rd_valid = mem_next.rd_valid;
        store_in.mem_op = mem_next.mem_op;
        store_in.load_not_store = load_not_store;
    end

    logic enq_req_load, enq_req_store, deq_req_load, deq_req_store, enq_ready_load, enq_ready_store, deq_ready_load, deq_ready_store;
    rvfi_mem_t rvfi_mem_info_load, rvfi_mem_info_store;
    logic mem_in_flight;
    assign word_rdata = bmem_rdata[(mem_pkt_fu.address[4:2]*32)+:32]; 

    assign enq_req_load = bmem_resp && mem_pkt_fu.load_not_store && mem_pkt_fu.valid;
    assign enq_req_store = bmem_resp && !mem_pkt_fu.load_not_store && mem_pkt_fu.valid;
    assign deq_req_load = rvfi_load && deq_req;
    assign deq_req_store = !rvfi_load && deq_req;

    assign rvfi_mem_info_in.rvfi_mem_addr = mem_pkt_fu.address;
    assign rvfi_mem_info_in.rvfi_mem_rmask = mem_pkt_fu.r_mask << mem_pkt_fu.address_start[1:0];
    assign rvfi_mem_info_in.rvfi_mem_wmask = mem_pkt_fu.w_mask << mem_pkt_fu.address_start[1:0];
    assign rvfi_mem_info_in.rvfi_mem_rdata = masked_rdata << mem_pkt_fu.address_start[1:0]*8;
    assign rvfi_mem_info_in.rob_addr = mem_pkt_fu.rob_addr;
    assign rvfi_mem_info_in.rvfi_mem_wdata = bmem_wdata;

    assign rvfi_mem_info = (deq_req_load) ? rvfi_mem_info_load : (deq_req_store) ? rvfi_mem_info_store : '0;

    load_info_queue #(.WIDTH($bits(rvfi_mem_info)), .DEPTH(4)) load_info_queue //TODO: it is possible that the depth here isn't large enough
    (
        .clk(clk),
        .rst(rst | branch_miss),
        .enq_req(enq_req_load),
        .enq_data(rvfi_mem_info_in),
        .enq_ready(enq_ready_load),
        .deq_req(deq_req_load),
        .deq_data(rvfi_mem_info_load),
        .deq_ready(deq_ready_load),
        .rvfi_rob_addr(rvfi_rob_addr)
    );

        fifo #(.WIDTH($bits(rvfi_mem_info)), .DEPTH(4)) store_info_fifo //TODO: it is possible that the depth here isn't large enough
    (
        .clk(clk),
        .rst(rst | branch_miss),
        .enq_req(enq_req_store),
        .enq_data(rvfi_mem_info_in),
        .enq_ready(enq_ready_store),
        .deq_req(deq_req_store),
        .deq_data(rvfi_mem_info_store),
        .deq_ready(deq_ready_store)
    );


    // Register updates for the funtional unit and writeback stage
    always_ff @(posedge clk) begin
        if (rst | branch_miss) begin
            mem_pkt_fu <= '0;
            issue_valid_reg <= '0;
            got_response <= '0;
            masked_rdata_reg <= '0;
            rvfi_rob_addr <= '0;
        end else begin
            mem_pkt_fu <= (deq_store) ? store_out : (deq_load) ? load_out : mem_pkt_fu; //we can only let issue happen if we commit from our writeback
            issue_valid_reg <= (deq_store || deq_load) ? '1 : (taking_from_mem) ? '0 : issue_valid_reg;
            got_response <= (bmem_resp) ? '1 : (deq_store || deq_load) ? '0 : got_response;
            masked_rdata_reg <= (bmem_resp) ? masked_rdata : masked_rdata_reg; 
            rvfi_rob_addr <= rob_head;
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
        bmem_wdata = 'x;


        case (mem_pkt_fu.mem_op)
            load_f3_lb : masked_rdata = {{24{word_rdata[7 +8 *mem_pkt_fu.address_start[1:0]]}}, word_rdata[8 *mem_pkt_fu.address_start[1:0] +: 8]};
            load_f3_lbu: masked_rdata = {{24{1'b0}}, word_rdata[8 *mem_pkt_fu.address_start[1:0] +: 8]};
            load_f3_lh : masked_rdata = {{16{word_rdata[15+16*mem_pkt_fu.address_start[1]]}}, word_rdata[16*mem_pkt_fu.address_start[1] +: 16]};
            load_f3_lhu: masked_rdata = {{16{1'b0}}, word_rdata[16*mem_pkt_fu.address_start[1] +: 16]};
            load_f3_lw : masked_rdata = word_rdata;
            default    : masked_rdata = '0;
        endcase
        case (mem_pkt_fu.mem_op)
            store_f3_sb: bmem_wdata[8  * mem_pkt_fu.address_start[1:0] +: 8 ] = mem_pkt_fu.rs2_data[7 :0];
            store_f3_sh: bmem_wdata[16 * mem_pkt_fu.address_start[1]   +: 16] = mem_pkt_fu.rs2_data[15:0];
            store_f3_sw: bmem_wdata = mem_pkt_fu.rs2_data;
            default    : bmem_wdata = 'x;
        endcase
        bmem_addr = mem_pkt_fu.address;
        bmem_rmask = (issue_valid_reg && !got_response) ? mem_pkt_fu.r_mask << mem_pkt_fu.address_start[1:0]: '0;
        bmem_wmask = (issue_valid_reg && !got_response) ? mem_pkt_fu.w_mask << mem_pkt_fu.address_start[1:0] : '0;
        // bmem_wdata = mem_pkt_fu.rs2_data; // will only matter for stores, masks will handle if not used
    end


endmodule : mem_unit_lsq
