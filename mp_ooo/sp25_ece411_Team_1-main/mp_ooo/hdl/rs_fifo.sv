module rs_fifo 
import rv32i_types::*;
#(
    parameter WIDTH = 32,
    parameter DEPTH = 4
)
(
    input  logic                            clk,
    input  logic                            rst,

    input cdb_t                             cdb,

    input logic                             enq_req,
    input rs_t                              enq_data,
    output logic                            enq_ready,

    input logic                             deq_req,
    output rs_t                             deq_data,
    output logic                            deq_ready,
    output logic                            near_full
);

    localparam ADDR_WIDTH = $clog2(DEPTH);

    rs_t mem[DEPTH];
    logic [ADDR_WIDTH-1:0] head, tail;
    logic [ADDR_WIDTH:0] count;

    assign enq_ready = (count < (DEPTH[ADDR_WIDTH:0]));
    assign deq_ready = (count > '0);
    assign deq_data = mem[head];
    // assign near_full = (count <= (ADDR_WIDTH+1)'(DEPTH-3)) ? '0 : '1;
    assign near_full = (count <= (ADDR_WIDTH+1)'($unsigned(DEPTH - 3))) ? 1'b0 : 1'b1;

    always_ff @ (posedge clk) begin
        if(rst) begin
            head <= '0;
            tail <= '0;
            count <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                mem[i] <= '0;
            end
        end
        else begin
            for (integer i = 0; i < DEPTH; i++) begin
                // Need check to ensure behavior as i and tail could be updating same reg
                if ( !(i == integer'(tail) && enq_req && enq_ready) && cdb.valid && cdb.rd_valid) begin
                    if (!mem[i].rs1_ready && mem[i].rs1_data[PHYS_REG_ADDR_WIDTH-1:0] == cdb.rd_paddr) begin
                        mem[i].rs1_ready <= '1;
                        mem[i].rs1_data <= cdb.rd_data;
                    end
                    if (!mem[i].rs2_ready && mem[i].rs2_data[PHYS_REG_ADDR_WIDTH-1:0] == cdb.rd_paddr) begin
                        mem[i].rs2_ready <= '1;
                        mem[i].rs2_data <= cdb.rd_data;
                    end
                end
            end
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
