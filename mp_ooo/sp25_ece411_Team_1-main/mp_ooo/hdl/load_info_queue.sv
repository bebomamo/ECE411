module load_info_queue
import rv32i_types::*;
#(
    parameter WIDTH = 32,
    parameter DEPTH = 8
)(
    input  logic                 clk,
    input  logic                 rst,

    input logic                 enq_req,
    input rvfi_mem_t     enq_data,
    output logic                enq_ready,

    input logic                 deq_req,
    output rvfi_mem_t    deq_data,
    output logic                deq_ready,
    output logic                near_empty,

    input logic [ROB_ADDR_WIDTH-1:0] rvfi_rob_addr
);

    localparam ADDR_WIDTH = $clog2(DEPTH);


    rvfi_mem_t  mem[DEPTH];
    logic valid[DEPTH];

    logic [ADDR_WIDTH:0] count;
    logic [ADDR_WIDTH-1:0] match_idx, free_idx;
    logic found_free, match_found;

    assign enq_ready = (count < (DEPTH[ADDR_WIDTH:0]));
    assign deq_ready = (count > '0) && match_found;
    assign deq_data = match_found ? mem[match_idx] : '0;
    assign near_empty = (count <= 1);



    always_comb begin
        found_free = '0;
        free_idx = '0;
        match_found = '0;
        match_idx = '0;

        for (integer unsigned i = 0; i < DEPTH; i++) begin
            if (!valid[i]) begin
                found_free = '1;
                free_idx = ADDR_WIDTH'(i);
                break;
            end
        end

        for (integer unsigned i = 0; i < DEPTH; i++) begin
            if (valid[i] && mem[i].rob_addr == rvfi_rob_addr) begin
                match_found = '1;
                match_idx = ADDR_WIDTH'(i);
                break;
            end
        end
    end

    always_ff @ (posedge clk) begin
        if(rst) begin
            count <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                valid[i] <= '0;
            end
        end
        else begin
            if(enq_req && enq_ready) begin
                mem[free_idx] <= enq_data;
                count <= (deq_req) ? count : count + 1'b1;
                valid[free_idx] <= '1;
            end
            if (deq_ready && deq_req) begin
                valid[match_idx] <= 1'b0;
                count <= (enq_req) ? count : count - 1'b1;
            end
        end
    end

endmodule
