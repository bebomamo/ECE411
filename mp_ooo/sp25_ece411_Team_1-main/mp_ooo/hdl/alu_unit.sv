module alu_unit
import rv32i_types::*;
(
    input logic         clk,
    input logic         rst,

    input rs_t          arith_next,
    input logic         issue_valid,

    // Comes from commit logic
    input logic         taking_from_alu, // TODO: needs commit implemented
    // Tell issue station unit is ready for new instruction
    output logic        arith_ready,

    // outputs to the commit stage to handle common data bus muxing
    output cdb_t         arith_cdb
);

    // Logic variables to make signed vs unsigned math simplier
    logic signed [31:0] as, bs;
    logic unsigned [31:0] au, bu;
    logic [31:0]        aluout;

    // instr to be executed and a corresponding logic to tell if it's valid
    rs_t                arith_pkt_fu;
    logic               issue_valid_reg;

    // Create signed a and b values for ALU
    // TODO: modify these to be ported by arith_pkt_fu
    assign as =   signed'(arith_pkt_fu.rs1_data);
    assign bs =   signed'(arith_pkt_fu.rs2_data);
    assign au = unsigned'(arith_pkt_fu.rs1_data);
    assign bu = unsigned'(arith_pkt_fu.rs2_data);

    // Register updates for the funtional unit and writeback stage
    always_ff @(posedge clk) begin
        if (rst) begin
            arith_pkt_fu <= '0;
            issue_valid_reg <= '0;
        end else begin
            arith_pkt_fu <= (taking_from_alu || !issue_valid_reg) ? arith_next : arith_pkt_fu; //we can only let issue happen if we commit from our writeback
            issue_valid_reg <= (taking_from_alu || !issue_valid_reg) ? issue_valid : issue_valid_reg;
        end
    end

    always_comb begin : common_data_bus_packaging
        arith_cdb.valid = valid_t'(issue_valid_reg);
        arith_cdb.rd_paddr = arith_pkt_fu.rd_paddr;
        arith_cdb.rd_data = aluout; //should be the output of the ALU operation
        arith_cdb.rob_addr = arith_pkt_fu.rob_addr;
        arith_cdb.rs1_data = arith_pkt_fu.rs1_data;
        arith_cdb.rs2_data = arith_pkt_fu.rs2_data;
        arith_cdb.rd_valid = arith_pkt_fu.rd_valid;
        arith_cdb.br_result = '0; //can't be taken from an ALU instruction
    end

    // Logic for performing alu operations
    always_comb begin : ALU_COMB
        unique case (arith_pkt_fu.alu_op)
            alu_op_add: aluout = au +   bu;
            alu_op_sll: aluout = au <<  bu[4:0];
            alu_op_sra: aluout = unsigned'(as >>> bu[4:0]);
            alu_op_sub: aluout = au -   bu;
            alu_op_xor: aluout = au ^   bu;
            alu_op_srl: aluout = au >>  bu[4:0];
            alu_op_or : aluout = au |   bu;
            alu_op_and: aluout = au &   bu;
            alu_op_slt: aluout = (as < bs) ? 32'd1 : 32'd0;
            alu_op_sltu: aluout = (au < bu) ? 32'd1 : 32'd0;
            default   : aluout = 'x;
        endcase
        arith_ready = taking_from_alu || !issue_valid_reg;  
        // if the currently operating fu instr is valid, then fu is NOT ready
    end


endmodule : alu_unit
