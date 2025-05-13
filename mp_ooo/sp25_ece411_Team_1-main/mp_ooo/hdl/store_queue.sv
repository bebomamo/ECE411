module store_queue 
import rv32i_types::*;
#(
    parameter WIDTH = 32,
    parameter DEPTH = 8
)(
    input  logic                 clk,
    input  logic                 rst,

    input logic                 enq_req,
    input lsq_t             enq_data,
    output logic                enq_ready,

    input logic                 deq_req,
    output lsq_t             deq_data,
    output logic                deq_ready,

    input logic [ROB_ADDR_WIDTH-1:0] rob_head,

    output logic [SQ_ADDR_WIDTH:0] store_count,  //hard coded size
    output logic [ROB_ADDR_WIDTH-1:0] store_head_age,
    output logic [ROB_ADDR_WIDTH-1:0] store_tail_age,
    output logic [SQ_DEPTH-1:0]                        store_valid,
    output logic [SQ_DEPTH-1:0][31:0]                  store_address,
    output logic [SQ_DEPTH-1:0][ROB_ADDR_WIDTH-1:0]    store_rob_addr
);

    localparam ADDR_WIDTH = $clog2(DEPTH);
    logic [31:0] dummy;

    lsq_t mem[DEPTH];
    logic [ADDR_WIDTH-1:0] head, tail, tail_idx;
    logic [ADDR_WIDTH:0] count;


    assign enq_ready = (count < (DEPTH[ADDR_WIDTH:0]));
    assign deq_ready = (count > '0);
    assign deq_data = mem[head];
    assign store_count = count;
    assign store_head_age = (mem[head].rob_addr >= rob_head) ? (mem[head].rob_addr - rob_head) : (5'd31- rob_head + mem[head].rob_addr);
    assign store_tail_age = (mem[tail_idx].rob_addr >= rob_head) ? (mem[tail_idx].rob_addr - rob_head) : (5'd31- rob_head + mem[tail_idx].rob_addr);
    assign tail_idx = (tail == 0)
                ? ADDR_WIDTH'(DEPTH - 1)
                : ADDR_WIDTH'(tail) - ADDR_WIDTH'(1);

    generate 
        for (genvar i = 0; i < DEPTH; i++) begin : storeq_outputs
            assign store_valid[i]     = mem[i].valid;
            assign store_address[i]   = mem[i].address;
            assign store_rob_addr[i]  = mem[i].rob_addr;
        end
    endgenerate

    always_ff @ (posedge clk) begin
        if(rst) begin
            head <= '0;
            tail <= '0; 
            count <= '0;

        end
        else begin
            if(enq_req && enq_ready) begin
                mem[tail] <= enq_data;
                tail <= tail + 1'b1;
                count <= (deq_req) ? count : count + 1'b1;
            end
            if (deq_ready && deq_req) begin
                head <= (head + 1'b1);
                count <= (enq_req) ? count : count - 1'b1;
            end
        end
    end



endmodule
