module id_rn_stage
import rv32i_types::*;
(
    //input   logic               clk,
    //input   logic               rst,
    // Free List Signals
    input   logic   [PHYS_REG_ADDR_WIDTH-1:0]   free_list_rename_paddr,
    output   logic                              free_list_deq_enb,
    input   logic                               free_list_deq_ready,
    // Pipeline Registers
    input   instr_t             if_id_stage_reg,
    output  instr_t             id_rn_stage_reg_next,
    // RAT + ARF Signals
    input   rat_arf_t           rs1_entry,
    input   rat_arf_t           rs2_entry,
    output  logic               rename_web,
    output  rat_arf_t           rename_entry,
    output  logic   [4:0]       rename_rd_addr
);

// Extended immediate signals, simplifies assignment
logic [31:0] i_imm, s_imm, b_imm, u_imm, j_imm;
logic [6:0] funct7, opcode;

assign i_imm  = {{21{if_id_stage_reg.instr[31]}}, if_id_stage_reg.instr[30:20]};
assign s_imm  = {{21{if_id_stage_reg.instr[31]}}, if_id_stage_reg.instr[30:25], if_id_stage_reg.instr[11:7]};
assign b_imm  = {{20{if_id_stage_reg.instr[31]}}, if_id_stage_reg.instr[7], if_id_stage_reg.instr[30:25], if_id_stage_reg.instr[11:8], 1'b0};
assign u_imm  = {if_id_stage_reg.instr[31:12], 12'h000};
assign j_imm  = {{12{if_id_stage_reg.instr[31]}}, if_id_stage_reg.instr[19:12], if_id_stage_reg.instr[20], if_id_stage_reg.instr[30:21], 1'b0};
assign funct7 = if_id_stage_reg.instr[31:25];
assign opcode = if_id_stage_reg.instr[6:0];

assign rename_rd_addr = if_id_stage_reg.instr[11:7];

// Instruction Meta Signals
assign id_rn_stage_reg_next.instr = if_id_stage_reg.instr;
assign id_rn_stage_reg_next.pc_rdata = if_id_stage_reg.pc_rdata;
assign id_rn_stage_reg_next.pc_wdata = if_id_stage_reg.pc_wdata;
assign id_rn_stage_reg_next.rs1_addr = if_id_stage_reg.instr[19:15];
assign id_rn_stage_reg_next.rs2_addr = if_id_stage_reg.instr[24:20];
assign id_rn_stage_reg_next.br_pred = if_id_stage_reg.br_pred;
// Decode Signals
assign id_rn_stage_reg_next.opcode = if_id_stage_reg.instr[6:0];

assign id_rn_stage_reg_next.rd_paddr = free_list_rename_paddr;


always_comb begin : decode_logic
    // Defaults, most instructions uses these
    // Decode Signals
    id_rn_stage_reg_next.rd_addr = if_id_stage_reg.instr[11:7];
    id_rn_stage_reg_next.rs1_valid = INVALID;
    id_rn_stage_reg_next.rs2_valid = INVALID;
    id_rn_stage_reg_next.rd_valid = VALID;
    id_rn_stage_reg_next.funct_unit = ARITH_UNIT;   // Most common
    id_rn_stage_reg_next.alu_op = 'x;
    id_rn_stage_reg_next.r_mask = '0;
    id_rn_stage_reg_next.w_mask = '0;
    // Dispatch Signals
    id_rn_stage_reg_next.rs1_ready = '0;
    id_rn_stage_reg_next.rs2_ready = '0;
    id_rn_stage_reg_next.rs1_data = 'x;
    id_rn_stage_reg_next.rs2_data = 'x;
    id_rn_stage_reg_next.funct3 = if_id_stage_reg.instr[14:12];
    id_rn_stage_reg_next.valid = INVALID;
    

    case(opcode)
        op_b_lui :
        begin
            // All data is derived from instruction, no need for register file access
            id_rn_stage_reg_next.rs1_data = u_imm;
            id_rn_stage_reg_next.rs1_ready = '1;
            id_rn_stage_reg_next.rs2_data = '0;
            id_rn_stage_reg_next.rs2_ready = '1;
            id_rn_stage_reg_next.alu_op = alu_op_add;
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
        end

        op_b_auipc :
        begin
            id_rn_stage_reg_next.rs1_data = if_id_stage_reg.pc_rdata;
            id_rn_stage_reg_next.rs1_ready = '1;
            id_rn_stage_reg_next.rs2_data = u_imm;
            id_rn_stage_reg_next.rs2_ready = '1;
            id_rn_stage_reg_next.alu_op = alu_op_add;
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
        end

        op_b_imm :
        begin
            id_rn_stage_reg_next.rs1_valid = VALID;
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
            id_rn_stage_reg_next.rs1_ready = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs1_data = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs1_entry.paddr} : rs1_entry.data;
            if(id_rn_stage_reg_next.funct3 == arith_f3_sll) begin
                id_rn_stage_reg_next.alu_op = alu_op_sll;
                id_rn_stage_reg_next.rs2_ready = '1;
                id_rn_stage_reg_next.rs2_data = {27'b0, if_id_stage_reg.instr[24:20]};       // shamt
            end
            else if (id_rn_stage_reg_next.funct3 == arith_f3_sr) begin
                id_rn_stage_reg_next.rs2_ready = '1;
                id_rn_stage_reg_next.rs2_data = {27'b0, if_id_stage_reg.instr[24:20]};       // shamt
                id_rn_stage_reg_next.alu_op = (funct7 == variant) ? alu_op_sra : alu_op_srl;
            end
            else begin
                id_rn_stage_reg_next.rs2_data = i_imm;
                id_rn_stage_reg_next.rs2_ready = '1;
                id_rn_stage_reg_next.alu_op = {1'b0, id_rn_stage_reg_next.funct3};
            end
        end

        op_b_reg :
        begin
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
            id_rn_stage_reg_next.rs1_valid = VALID;
            id_rn_stage_reg_next.rs1_ready = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs1_data = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs1_entry.paddr} : rs1_entry.data;
            id_rn_stage_reg_next.rs2_valid = VALID;
            id_rn_stage_reg_next.rs2_ready = (rs2_entry.renamed && id_rn_stage_reg_next.rs2_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs2_data = (rs2_entry.renamed && id_rn_stage_reg_next.rs2_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs2_entry.paddr} : rs2_entry.data;

            if(funct7 == mul) begin
                id_rn_stage_reg_next.funct_unit = MUL_DIV_UNIT;
            end

            if(id_rn_stage_reg_next.funct3 == arith_f3_add) begin
                id_rn_stage_reg_next.alu_op = (funct7 == variant) ? alu_op_sub : alu_op_add;
            end
            else if(id_rn_stage_reg_next.funct3 == arith_f3_sr) begin
                id_rn_stage_reg_next.alu_op = (funct7 == variant) ? alu_op_sra : alu_op_srl;
            end
            else begin
                id_rn_stage_reg_next.alu_op = {1'b0, id_rn_stage_reg_next.funct3};
            end
        end
        // ----------------- BRANCH and JUMPS target handled by COMMIT/RETIRE --------------------------
        op_b_jal :
        begin
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
            id_rn_stage_reg_next.rs1_ready = '1;
            id_rn_stage_reg_next.rs1_data = '0;
            id_rn_stage_reg_next.rs2_ready = '1;
            id_rn_stage_reg_next.rs2_data = '0;
            id_rn_stage_reg_next.funct_unit = BR_UNIT;
            id_rn_stage_reg_next.funct3 = branch_f3_beq;

        end

        op_b_jalr :
        begin
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
            id_rn_stage_reg_next.rs1_valid = VALID;
            id_rn_stage_reg_next.rs1_ready = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs2_ready = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs2_data = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs1_entry.paddr} : rs1_entry.data;
            id_rn_stage_reg_next.rs1_data = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs1_entry.paddr} : rs1_entry.data;
            id_rn_stage_reg_next.funct_unit = BR_UNIT;
            id_rn_stage_reg_next.funct3 = branch_f3_beq;
        end
        op_b_br :
        begin
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
            id_rn_stage_reg_next.rd_addr = '0;
            id_rn_stage_reg_next.rd_valid = INVALID;
            id_rn_stage_reg_next.rs1_valid = VALID;
            id_rn_stage_reg_next.rs1_ready = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs1_data = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs1_entry.paddr} : rs1_entry.data;
            id_rn_stage_reg_next.rs2_valid = VALID;
            id_rn_stage_reg_next.rs2_ready = (rs2_entry.renamed && id_rn_stage_reg_next.rs2_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs2_data = (rs2_entry.renamed && id_rn_stage_reg_next.rs2_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs2_entry.paddr} : rs2_entry.data;
            id_rn_stage_reg_next.funct_unit = BR_UNIT;
        end

        op_b_load :
        begin
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
            id_rn_stage_reg_next.rs1_valid = VALID;
            id_rn_stage_reg_next.rs1_ready = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs1_data = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs1_entry.paddr} : rs1_entry.data;
            id_rn_stage_reg_next.rs2_ready = '1;
            id_rn_stage_reg_next.rs2_data = i_imm;
            id_rn_stage_reg_next.funct_unit = MEM_UNIT;
            unique case (id_rn_stage_reg_next.funct3)
                load_f3_lb, load_f3_lbu: id_rn_stage_reg_next.r_mask = 4'b0001;
                load_f3_lh, load_f3_lhu: id_rn_stage_reg_next.r_mask = 4'b0011;
                load_f3_lw             : id_rn_stage_reg_next.r_mask = 4'b1111;
                default                : id_rn_stage_reg_next.r_mask = '0;
            endcase
        end

        op_b_store :
        begin
            id_rn_stage_reg_next.valid = (free_list_deq_ready || !id_rn_stage_reg_next.rd_valid) ? if_id_stage_reg.valid : INVALID;
            id_rn_stage_reg_next.rs1_valid = VALID;
            id_rn_stage_reg_next.rs1_ready = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs1_data = (rs1_entry.renamed && id_rn_stage_reg_next.rs1_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs1_entry.paddr} : rs1_entry.data;
            id_rn_stage_reg_next.rs2_valid = VALID;
            id_rn_stage_reg_next.rs2_ready = (rs2_entry.renamed && id_rn_stage_reg_next.rs2_addr != '0) ? '0 : '1;
            id_rn_stage_reg_next.rs2_data = (rs2_entry.renamed && id_rn_stage_reg_next.rs2_addr != '0) ? {{(32 - PHYS_REG_ADDR_WIDTH-1){1'b0}}, rs2_entry.paddr} : rs2_entry.data;
            id_rn_stage_reg_next.funct_unit = MEM_UNIT;
            id_rn_stage_reg_next.rd_valid = INVALID;
            unique case (id_rn_stage_reg_next.funct3)
                store_f3_sb: id_rn_stage_reg_next.w_mask = 4'b0001;
                store_f3_sh: id_rn_stage_reg_next.w_mask = 4'b0011;
                store_f3_sw: id_rn_stage_reg_next.w_mask = 4'b1111;
                default    : id_rn_stage_reg_next.w_mask = '0;
            endcase
        end
        endcase
end

always_comb begin : rename_logic
    rename_entry = 'x;
    rename_web = '1;
    free_list_deq_enb = '0;
    if (if_id_stage_reg.valid && free_list_deq_ready && id_rn_stage_reg_next.rd_valid) begin
        free_list_deq_enb = '1;
        rename_entry.renamed = '1;
        rename_entry.paddr = free_list_rename_paddr;
        rename_entry.valid = '1;
        rename_web = '0;        // ON
    end
end

endmodule : id_rn_stage
