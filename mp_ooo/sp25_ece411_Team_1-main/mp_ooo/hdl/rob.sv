module rob 
import rv32i_types::*;
(
    input logic                         rst,
    input logic                         clk,

    // Dispatch stage interaction
    input rob_t                         dispatch_entry, //writes an instr to tail while still in-order
    output logic [ROB_ADDR_WIDTH-1:0]   cur_rob_addr,

    // Writeback stage interaction
    input logic                         wb_ready_to_commit,
    input logic [ROB_ADDR_WIDTH-1:0]    wb_rob_addr,
    input cdb_t                              cdb_sel,

    // Commit stage interaction
    output rob_t                        head_entry,
    input logic                         retire_deq_req,

    // ROB control logic
    output logic                        rob_full,
    output logic                        rob_empty,
    output logic                        rob_near_full,

    //for lsq
    output logic  [ROB_ADDR_WIDTH-1:0]    rob_head_out
);
    // Commit stage interaction
    rob_t                        head_r_entry; //reads head entry to check if we can retire it
    logic                        wb_on_head_flag;
    logic                        no_longer_wb_flag;

    localparam INSTR_INFO_WIDTH = $bits(dispatch_entry.instr_info);
    localparam RS_DATA_INFO_WIDTH = $bits(rs_data_info_t);
    // TODO: confirm the following 
    // 4 ports : 
    // port 1: writing the instruction leaving the dispatch stage
    // port 2: writing to 'status' once we know an instruction is done
    // port 3: reading from the "commit" stage to see if we can retire an instruction
    // port 4: writing to retire an intruction by invalidating the rob entry

    // cs and web's and rob_addr(same number as PRF registers)
    logic [3:0] csb;
    logic [3:0] valid_web;
    logic [3:0] status_web;
    logic [3:0] type_web;
    logic [3:0] paddr_web;
    logic [3:0] instr_info_web;
    logic [3:0] rs_data_info_web;
    logic [3:0] addr_web;
    logic [3:0] br_pred_web;
    logic [3:0] br_result_web;
    logic [ROB_ADDR_WIDTH-1:0] rob_addr [4]; //rob entry selector/addr

    // data in and out logics
    logic valid_in      [4];
    logic valid_out     [4];
    logic status_in     [4]; //WAIT and DONE type options (see rob_status_t)
    logic status_out    [4];
    logic [1:0] type_in [4]; //2 bits for alu, br, and mem op-types
    logic [1:0] type_out[4];
    logic [PHYS_REG_ADDR_WIDTH-1:0] paddr_in  [4];
    logic [PHYS_REG_ADDR_WIDTH-1:0] paddr_out [4];
    logic [INSTR_INFO_WIDTH-1:0] instr_info_in  [4];
    logic [INSTR_INFO_WIDTH-1:0] instr_info_out [4];
    logic [RS_DATA_INFO_WIDTH-1:0] rs_data_info_in  [4];
    logic [RS_DATA_INFO_WIDTH-1:0] rs_data_info_out [4];
    logic [4:0] addr_in [4];
    logic [4:0] addr_out[4];
    logic br_pred_in    [4]; 
    logic br_pred_out   [4];
    logic br_result_in  [4];
    logic br_result_out [4];

    // ROB "queue"
    logic [ROB_ADDR_WIDTH-1:0] rob_head;
    logic [ROB_ADDR_WIDTH-1:0] rob_tail;
    logic inc_count;
    logic dec_count;
    logic [ROB_ADDR_WIDTH-1:0] count; 
    logic [ROB_ADDR_WIDTH-1:0] full_count;
    assign full_count = '1;
    assign rob_head_out = rob_head;

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(1), .REGISTER_INPUTS(0)) valid_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(valid_web),     
        .addr(rob_addr),
        .din(valid_in),
        .dout(valid_out)
    );

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(1), .REGISTER_INPUTS(0)) status_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(status_web),     
        .addr(rob_addr),
        .din(status_in),
        .dout(status_out)
    );

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(2), .REGISTER_INPUTS(0)) type_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(type_web),     
        .addr(rob_addr),
        .din(type_in),
        .dout(type_out)
    );

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(PHYS_REG_ADDR_WIDTH), .REGISTER_INPUTS(0)) paddr_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(paddr_web),     
        .addr(rob_addr),
        .din(paddr_in),
        .dout(paddr_out)
    );

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(INSTR_INFO_WIDTH), .REGISTER_INPUTS(0)) instr_info_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(instr_info_web),     
        .addr(rob_addr),
        .din(instr_info_in),
        .dout(instr_info_out)
    );

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(RS_DATA_INFO_WIDTH), .REGISTER_INPUTS(0)) rs_data_info_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(rs_data_info_web),     
        .addr(rob_addr),
        .din(rs_data_info_in),
        .dout(rs_data_info_out)
    );

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(5), .REGISTER_INPUTS(0)) addr_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(addr_web),     
        .addr(rob_addr),
        .din(addr_in),
        .dout(addr_out)
    );

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(1), .REGISTER_INPUTS(0)) br_pred_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(br_pred_web),     
        .addr(rob_addr),
        .din(br_pred_in),
        .dout(br_pred_out)
    );

    param_ff_array #(.NUM_PORTS(4), .S_INDEX(ROB_ADDR_WIDTH), .WIDTH(1), .REGISTER_INPUTS(0)) br_result_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(br_result_web),     
        .addr(rob_addr),
        .din(br_result_in),
        .dout(br_result_out)
    );


    assign rob_empty = (count == '0) ? '1 : '0;
    assign rob_full = (count == full_count) ? '1 : '0;
    assign rob_near_full = (count <= full_count - ROB_ADDR_WIDTH'(3)) ? '0 : '1;

    // TODO: make sure this works
    // ROB queue and control logic
    always_ff @(posedge clk) begin
        if (rst) begin
            rob_head <= '0;
            rob_tail <= '0;
            count <= '0;
        end else begin
            if (dispatch_entry.valid == VALID) begin
                rob_tail <= rob_tail + ROB_ADDR_WIDTH'(1);
            end
            if (retire_deq_req) begin
                rob_head <= rob_head + ROB_ADDR_WIDTH'(1);
            end 

            count <= count + inc_count - dec_count; //update count, which limits entering to rob and may stall pipeline if rob is full
        end
    end

    always_comb begin : count_logic
        if (count >= full_count) begin
            inc_count = 1'b0;
        end else if (dispatch_entry.valid == INVALID) begin 
            inc_count = 1'b0;
        end else begin
            inc_count = 1'b1;
        end

        if (retire_deq_req) begin
            dec_count = 1'b1;
        end else begin
            dec_count = 1'b0;
        end
    end

    always_comb begin : dispatch_stage_write_to_rob
        // This interaction is done with the first port
        cur_rob_addr = rob_tail;

        rs_data_info_web[0] = '1;
        

        csb[0] = '0;
        if(dispatch_entry.valid == INVALID) begin
            valid_web[0] = '1;
            status_web[0] = '1;
            type_web[0] = '1;
            paddr_web[0] = '1;
            instr_info_web[0] = '1;
            addr_web[0] = '1;
            br_pred_web[0] = '1;
            br_result_web[0] = '1;
        end else begin
            valid_web[0] = '0;
            status_web[0] = '0;
            type_web[0] = '0;
            paddr_web[0] = '0;
            instr_info_web[0] = '0;
            addr_web[0] = '0;
            br_pred_web[0] = '0;
            br_result_web[0] = '0;
        end
        rob_addr[0] = rob_tail;

        valid_in[0] = dispatch_entry.valid;
        status_in[0] = dispatch_entry.status;
        type_in[0] = dispatch_entry.op;
        paddr_in[0] = dispatch_entry.rd_paddr;
        instr_info_in[0] = dispatch_entry.instr_info;
        rs_data_info_in[0] = '0;
        addr_in[0] = dispatch_entry.rd_addr;
        br_pred_in[0] = dispatch_entry.br_pred;
        br_result_in[0] = dispatch_entry.br_result;
    end

    // TODO: we may need more ports like this... 1 per functional ex unit
    always_comb begin : wb_stage_write_status
        // This interaction is done with the second port
        csb[1] = '0;
        valid_web[1] = '1;
        status_web[1] = (cdb_sel.valid) ? '0 : '1; //always write, since the wb_ready_to_commit will be accurate
        type_web[1] = '1;
        paddr_web[1] = '1;
        instr_info_web[1] = '1;
        rs_data_info_web[1] = (cdb_sel.valid) ? '0 : '1;
        addr_web[1] = '1;
        br_pred_web[1] = '1;
        br_result_web[1] = (cdb_sel.valid) ? '0 : '1;
;
        rob_addr[1] = wb_rob_addr;

        valid_in[1] = '0;
        status_in[1] = wb_ready_to_commit;
        type_in[1] = '0;
        paddr_in[1] = '0;
        instr_info_in[1] = '0;
        rs_data_info_in[1] = {cdb_sel.rs1_data, cdb_sel.rs2_data};
        addr_in[1] = '0;
        br_pred_in[1] = '0;
        br_result_in[1] = cdb_sel.br_result;
    end

    always_comb begin : commit_stage_read_for_retire
        // This interaction is done with the third port
        csb[2] = '0;
        valid_web[2] = '1;
        status_web[2] = '1;
        type_web[2] = '1;
        paddr_web[2] = '1;
        instr_info_web[2] = '1;
        rs_data_info_web[2] = '1;
        addr_web[2] = '1;
        br_pred_web[2] = '1;
        br_result_web[2] = '1;
        rob_addr[2] = rob_head;
        //NOT WRITING JUST READING FROM rob_head to see if we can retire the entry

        valid_in[2] = '0;
        status_in[2] = '0;
        type_in[2] = '0;
        paddr_in[2] = '0;
        instr_info_in[2] = '0;
        rs_data_info_in[2] = '0;
        addr_in[2] = '0;
        br_pred_in[2] = '0;
        br_result_in[2] = '0;

        head_r_entry.valid = valid_t'(valid_out[2]);
        head_r_entry.status = rob_status_t'(status_out[2]);
        head_r_entry.op = type_out[2];
        head_r_entry.rd_paddr = paddr_out[2];
        head_r_entry.instr_info = instr_info_out[2];
        head_r_entry.rs_info = rs_data_info_out[2];
        head_r_entry.rd_addr = addr_out[2];
        head_r_entry.br_pred = taken_t'(br_pred_out[2]);
        head_r_entry.br_result = taken_t'(br_result_out[2]);
    end
    assign head_entry = head_r_entry; //this writes to the output port

    always_comb begin : commit_stage_write_to_retire
        // This interaction is done with the fourth port
        csb[3] = '0;
        valid_web[3] = (head_r_entry.status == DONE) ? '0 : '1;
        status_web[3] = (head_r_entry.status == DONE) ? '0 : '1;
        type_web[3] = '1;
        paddr_web[3] = '1;
        instr_info_web[3] = '1;
        rs_data_info_web[3] = '1;
        addr_web[3] = '1;
        br_pred_web[3] = '1;
        br_result_web[3] = '1;
        rob_addr[3] = rob_head;

        valid_in[3] = '0;
        status_in[3] = rob_status_t'('0);
        type_in[3] = '0;
        paddr_in[3] = '0;
        instr_info_in[3] = '0;
        rs_data_info_in[3] = '0;
        addr_in[3] = '0;
        br_pred_in[3] = '0;
        br_result_in[3] = '0;
    end


endmodule : rob
