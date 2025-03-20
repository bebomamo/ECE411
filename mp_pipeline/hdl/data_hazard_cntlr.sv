module data_hazard_cntlr
import rv32i_types::*;
(
    input   logic           clk,
    input   logic           rst,
    input   logic   [4:0]   rs1_s,
    input   logic   [4:0]   rs2_s,
    input   logic   [4:0]   rd_s_1,
    input   logic   [4:0]   rd_s_2,
    input   logic   [6:0]   mem_stage_opcode,
    input   logic           mem_stage_valid,
    input   logic   [6:0]   wb_stage_opcode,
    input   logic           wb_stage_valid,
    input   logic           dmem_stall,

    input   logic   [31:0]  rs1_v,
    input   logic   [31:0]  rs2_v,
    output  logic   [31:0]  a,
    output  logic   [31:0]  b,
    input   logic   [31:0]  mem_stage_aluout,
    // input   logic   [31:0]  mem_stage_dmemout, 
    input   logic   [31:0]  wb_stage_val,
    output  logic           use_after_load
);

    logic [3:0] hazard_selector;
    logic [3:0] hazard_selector_next;
    logic       use_after_load_next;
    logic [31:0] retired_wb_val;

    always_ff @(posedge clk) begin
        if (rst) begin
            hazard_selector <= '0;
            use_after_load <= '0;
            retired_wb_val <= '0;
        end else if (use_after_load) begin
            hazard_selector <= hazard_selector;
            use_after_load <= '0;
            retired_wb_val <= wb_stage_val;
        end else if (dmem_stall) begin
            hazard_selector <= hazard_selector;
            use_after_load <= use_after_load;
            retired_wb_val <= retired_wb_val;
        end else begin
            hazard_selector <= hazard_selector_next;
            use_after_load <= use_after_load_next;
            retired_wb_val <= wb_stage_val;
        end
    end

    /* DETECTION */ 
    always_comb begin
        if (rs1_s == 5'b00000) begin
            hazard_selector_next[1:0] = 2'b00;
        end else if (rs1_s == rd_s_1 && (mem_stage_opcode != op_b_store) && (mem_stage_opcode[6] != 1'b1) && mem_stage_valid) begin
            if(mem_stage_opcode == op_b_load) begin
                hazard_selector_next[1:0] = 2'b11; //load version
            end else begin
                hazard_selector_next[1:0] = 2'b01; //alu version
            end
        end else if (rs1_s == rd_s_2 && (wb_stage_opcode != op_b_store) && (wb_stage_opcode[6] != 1'b1) && wb_stage_valid) begin
            hazard_selector_next[1:0] = 2'b10; 
        end else begin
            hazard_selector_next[1:0] = 2'b00;
        end

        if (rs2_s == 5'b00000) begin
            hazard_selector_next[3:2] = 2'b00;
        end else if (rs2_s == rd_s_1 && (mem_stage_opcode != op_b_store) && (mem_stage_opcode[6] != 1'b1) && mem_stage_valid) begin
            if(mem_stage_opcode == op_b_load) begin
                hazard_selector_next[3:2] = 2'b11; //load version
            end else begin
                hazard_selector_next[3:2] = 2'b01; //alu version
            end
        end else if (rs2_s == rd_s_2 && (wb_stage_opcode != op_b_store) && (wb_stage_opcode[6] != 1'b1) && wb_stage_valid) begin
            hazard_selector_next[3:2] = 2'b10; 
        end else begin
            hazard_selector_next[3:2] = 2'b00;
        end

        if ((rs1_s == rd_s_1 || rs2_s == rd_s_1) && (mem_stage_opcode == op_b_load) && mem_stage_valid) begin
            use_after_load_next = '1;
        end else begin
            use_after_load_next = '0;
        end
    end

    /* FORWARD */
    always_comb begin
        unique case (hazard_selector)
            normal         : begin
                a = rs1_v;
                b = rs2_v;
            end
            rs1_rd1        : begin
                a = mem_stage_aluout;
                b = rs2_v;
            end
            rs1_rd1l       : begin
                a = wb_stage_val;
                b = rs2_v;
            end
            rs1_rd2        : begin
                a = wb_stage_val;
                b = rs2_v;
            end
            rs2_rd1        : begin
                a = rs1_v;
                b = mem_stage_aluout;
            end
            rs2_rd1l       : begin
                a = rs1_v;
                b = wb_stage_val;
            end
            rs2_rd2        : begin
                a = rs1_v;
                b = wb_stage_val;
            end
            r1_1_r2_1      : begin
                a = mem_stage_aluout;
                b = mem_stage_aluout;
            end
            r1_1l_r2_1l    : begin
                a = wb_stage_val;
                b = wb_stage_val;
            end
            r1_1_r2_2      : begin
                a = mem_stage_aluout;
                b = wb_stage_val;
            end
            r1_1l_r2_2     : begin
                a = wb_stage_val;
                b = retired_wb_val;
            end
            r1_2_r2_1      : begin
                a = wb_stage_val;
                b = mem_stage_aluout;
            end
            r1_2_r2_1l     : begin
                a = retired_wb_val;
                b = wb_stage_val;
            end
            r1_2_r2_2      : begin
                a = wb_stage_val;
                b = wb_stage_val;
            end   
            default        : begin
                a = rs1_v;
                b = rs2_v;
            end
        endcase
    end


endmodule : data_hazard_cntlr