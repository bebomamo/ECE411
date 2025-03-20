module alu
import rv32i_types::*;
(
    input   logic   [2:0]   aluop,
    input   logic   [31:0]  a, b,
    output  logic   [31:0]  f,
    input   logic           slts
);

    logic signed   [31:0] as;
    logic signed   [31:0] bs;
    logic unsigned [31:0] au;
    logic unsigned [31:0] bu;

    assign as =   signed'(a);
    assign bs =   signed'(b);
    assign au = unsigned'(a);
    assign bu = unsigned'(b);

    always_comb begin
        unique case (aluop)
            alu_op_add: f = a +   b;
            alu_op_sll: f = au <<  bu[4:0];
            alu_op_sra: begin
                if(slts) begin
                    f = (as < bs) ? 32'd1 : 32'd0;
                end else begin
                    f = unsigned'(as >>> bu[4:0]);
                end
            end
            alu_op_sub: begin
                if(slts) begin
                    f = (au < bu) ? 32'd1 : 32'd0;
                end else begin
                    f = a -   b;
                end
            end
            alu_op_xor: f = au ^   bu;
            alu_op_srl: f = au >>  bu[4:0];
            alu_op_or : f = au |   bu;
            alu_op_and: f = au &   bu;
            default   : f = 'x;
        endcase
    end



endmodule : alu
