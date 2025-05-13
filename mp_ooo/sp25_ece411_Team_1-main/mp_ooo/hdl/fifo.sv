module fifo 
import rv32i_types::*;
#(
    parameter WIDTH = 32,
    parameter DEPTH = 8,
    parameter CUSTOM = DEFAULT //compare with fifo_custom_t in types.sv
)(
    input  logic                 clk,
    input  logic                 rst,

    input logic                 enq_req,
    input logic [WIDTH-1:0]     enq_data,
    output logic                enq_ready,

    input logic                 deq_req,
    output logic [WIDTH-1:0]    deq_data,
    output logic                deq_ready,
    output logic                near_empty
);

    localparam ADDR_WIDTH = $clog2(DEPTH);


    logic [WIDTH-1:0] mem[DEPTH];
    logic [ADDR_WIDTH-1:0] head, tail;
    logic [ADDR_WIDTH:0] count;

    assign enq_ready = (count < (DEPTH[ADDR_WIDTH:0]));
    assign deq_ready = (count > '0);
    assign deq_data = mem[head];
    assign near_empty = (count <= 1);

    always_ff @ (posedge clk) begin
        if(rst) begin
            head <= '0;
            tail <= '0;
            if (CUSTOM == FREE_LIST) begin
                count <= DEPTH[ADDR_WIDTH:0];
                for (integer i = 0; i < DEPTH; i++) begin
                    mem[i] <= WIDTH'(unsigned'(i));
                end
            end
            else begin    
                count <= '0;
            end
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
