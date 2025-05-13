module mul_div_unit
import rv32i_types::*;
(
    input   logic   clk,
    input   logic   rst,
    input   logic   issue_valid,
    input   rs_t    mul_div_next,
    output  logic   mul_div_ready,
    output  cdb_t   mul_div_result,
    input   logic   taking_from_mul_div

);
    localparam NUM_STAGES = 6;
    localparam SIGNED_TC = 1;
    localparam UNSIGNED_TC = 0;

    // Holds result of a * b
    logic [63:0]    product;
    logic tc;   // Two's Complement control

    logic [31:0]    u_quotient;
    logic [31:0]    u_remainder;
    logic           u_divide_by_0;

    logic [31:0]    s_quotient;
    logic [31:0]    s_remainder;
    logic           s_divide_by_0;

    logic s_overflow;

    logic wb_reg_waiting;

    cdb_t mul_div_wb_reg;
    rs_t rs_pipe[NUM_STAGES-1];
    rs_t rs_entry;

    assign mul_div_result = mul_div_wb_reg;
    // Result ready in NUM_STAGES - 1 clock cycles, NUM_STAGE >= 2
    DW_mult_pipe #(32, 32, NUM_STAGES, 1, 2, 0) mult_unit_i 
    (
        .clk(clk),
        .rst_n(~rst),               // Active Low
        .en(~wb_reg_waiting),        // Active high
        .tc(tc),                    // Unsigned - 0, Signed - 1
        .a(mul_div_next.rs2_data),  // Multipler
        .b(mul_div_next.rs1_data),  // Multiplicand
        .product(product)
    );

    // Signed
    DW_div_pipe #(32, 32, SIGNED_TC, 1, NUM_STAGES, 1, 2, 0) div_signed_unit_i 
    (
        .clk(clk), 
        .rst_n(~rst), 
        .en(~wb_reg_waiting),
        .a(mul_div_next.rs1_data),  // Dividend
        .b(mul_div_next.rs2_data),  // Divisor
        .quotient(s_quotient),
        .remainder(s_remainder), 
        .divide_by_0(s_divide_by_0) 
    );

    // Unsigned
    DW_div_pipe #(32, 32, UNSIGNED_TC, 1, NUM_STAGES, 1, 2, 0) div_unsigned_unit_i 
    (
        .clk(clk), 
        .rst_n(~rst), 
        .en(~wb_reg_waiting),
        .a(mul_div_next.rs1_data),
        .b(mul_div_next.rs2_data),
        .quotient(u_quotient),
        .remainder(u_remainder), 
        .divide_by_0(u_divide_by_0) 
    );

    always_comb begin : Mul_Div_Logic
        rs_entry = mul_div_next;
        rs_entry.valid = valid_t'(issue_valid);
        case(mul_div_next.mul_div_op)
            // Lower word result, Upperword result (unsigned * unsigned)
            mul_f3_mul, mul_f3_mulhu : 
                tc = '0;
            // Upperword result (signed * signed), Upperword result (signed * unsigned), rs1 - unsigned, rs2 - signed
            mul_f3_mulh, mul_f3_mulhsu :
                tc = '1;
            default :
                tc = '0;
        endcase
    end

    // 0 - if all ones (count at limit), 1 - if any zeros
    assign mul_div_ready = !wb_reg_waiting;
    assign wb_reg_waiting = !taking_from_mul_div && mul_div_wb_reg.valid;

    assign s_overflow = (32'h80000000 == mul_div_next.rs1_data && 32'hFFFFFFFF == mul_div_next.rs2_data);

    always_ff @(posedge clk) begin : Registers
        if (rst) begin
            mul_div_wb_reg <= '0;
            for (integer i = 0; i < NUM_STAGES-1; i++) begin
                    rs_pipe[i] <= '0;
            end
            
        end
        else begin
            rs_pipe[0] <= rs_entry;     // Fill in entry, may or may not be valid
            // Can advance if cdb reg is invalid or wb is taking cdb
            // if (!wb_reg_waiting) begin
            if (!wb_reg_waiting) begin
                for (integer i = 1; i < NUM_STAGES-1; i++) begin
                    rs_pipe[i] <= rs_pipe[i - 1];
                end
 
                mul_div_wb_reg.rd_paddr <= rs_pipe[NUM_STAGES-2].rd_paddr;
                mul_div_wb_reg.valid <= rs_pipe[NUM_STAGES-2].valid;
                mul_div_wb_reg.rob_addr <= rs_pipe[NUM_STAGES-2].rob_addr;
                mul_div_wb_reg.rs1_data <= rs_pipe[NUM_STAGES-2].rs1_data;
                mul_div_wb_reg.rs2_data <= rs_pipe[NUM_STAGES-2].rs2_data;
                mul_div_wb_reg.rd_valid <= rs_pipe[NUM_STAGES-2].rd_valid;

                case(rs_pipe[NUM_STAGES-2].mul_div_op)
                    // Lower word result
                    mul_f3_mul :  begin
                        mul_div_wb_reg.rd_data <= product[31:0];
                    end
                    // Upperword result (signed * signed)
                    mul_f3_mulh, mul_f3_mulhsu, mul_f3_mulhu : begin
                        mul_div_wb_reg.rd_data <= product[63:32];
                    end
                    mul_f3_div : begin
                        mul_div_wb_reg.rd_data <= (s_divide_by_0) ? '1 : (s_overflow) ? 32'h80000000 : s_quotient;
                    end
                    mul_f3_divu : begin
                        mul_div_wb_reg.rd_data <= (u_divide_by_0) ? '1 : u_quotient;
                    end
                    mul_f3_rem : begin
                        mul_div_wb_reg.rd_data <= (s_divide_by_0) ? s_remainder : (s_overflow) ? '0 : s_remainder;
                    end
                    mul_f3_remu : begin
                        mul_div_wb_reg.rd_data <= (s_divide_by_0) ? u_remainder : u_remainder;
                end
                endcase
            end
        end
    end

endmodule : mul_div_unit
