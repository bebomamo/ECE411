module br_unit
import rv32i_types::*;
(
    input logic         clk,
    input logic         rst,

    input rs_t          br_next,
    input logic         issue_valid,

    // Comes from commit logic
    input logic         taking_from_br,

    // Tell issue station unit is ready for new instruction
    output logic        br_ready,

    // outputs to the commit stage to handle common data bus muxing
    output cdb_t         br_cdb
);

    logic signed [31:0] as, bs;
    logic unsigned [31:0] au, bu;
    assign as =   signed'(br_next.rs1_data);
    assign bs =   signed'(br_next.rs2_data);
    assign au = unsigned'(br_next.rs1_data);
    assign bu = unsigned'(br_next.rs2_data);

    cdb_t cdb_reg;
    logic br_en;
    logic br_reg_waiting;

    assign br_cdb = cdb_reg;
    assign br_reg_waiting = cdb_reg.valid && !taking_from_br;
    assign br_ready = !cdb_reg.valid  || !br_reg_waiting;

    // Register updates for the funtional unit and writeback stage
    always_ff @(posedge clk) begin
        if (rst) begin
            cdb_reg <= '0;
        end
        if (br_ready) begin
            cdb_reg.valid <= valid_t'(issue_valid);   // Only mark valid if issued
            cdb_reg.br_result <= br_en;
            cdb_reg.rd_paddr <= br_next.rd_paddr;
            cdb_reg.rd_data <= br_next.pc_wdata;
            cdb_reg.rs1_data <= br_next.rs1_data;
            cdb_reg.rs2_data <= br_next.rs2_data;
            cdb_reg.rob_addr <= br_next.rob_addr;
            cdb_reg.rd_valid <= br_next.rd_valid;
        end

    end

    // Logic for performing br operations, jumps will have rs1_data = rs2_data
    // and op beq
    always_comb begin : BR_COMB
        unique case (br_next.branch_op)
            branch_f3_beq : br_en = (au == bu);
            branch_f3_bne : br_en = (au != bu);
            branch_f3_blt : br_en = (as <  bs);
            branch_f3_bge : br_en = (as >=  bs);
            branch_f3_bltu: br_en = (au <  bu);
            branch_f3_bgeu: br_en = (au >=  bu);
            default       : br_en = 1'bx;
        endcase
    end


endmodule : br_unit
