module rrf
import rv32i_types::*;
(
    input logic clk,
    input logic rst,

    input rob_t head_entry,

    output logic [PHYS_REG_ADDR_WIDTH-1:0] freed_paddr,
    output logic free_list_enq_enb,

    output logic [PHYS_REG_ADDR_WIDTH-1:0] commit_paddr,
    output logic    retire_deq_req,
    output logic    branch_miss,
    output logic  [31:0]  branch_target,

    input logic rob_empty,
    output logic [4:0] commit_rd_addr,
    output logic commit_arf_web,
    output rob_t rvfi_rob_entry,
    input rat_arf_t                        rat_entry_to_update,
    output logic commit_addr_stay_renamed,
    output logic retire_prf_web,
    output logic [PHYS_REG_ADDR_WIDTH-1:0] retire_prf_paddr
);
    // Extended immediate signals, simplifies assignment
    logic [31:0] i_imm, b_imm, j_imm;


    rob_t head_entry_reg; 
    rob_t head_reg_next;

    assign i_imm  = {{21{head_entry.instr_info.instr[31]}}, head_entry.instr_info.instr[30:20]};
    assign b_imm  = {{20{head_entry.instr_info.instr[31]}}, head_entry.instr_info.instr[7], head_entry.instr_info.instr[30:25], head_entry.instr_info.instr[11:8], 1'b0};
    assign j_imm  = {{12{head_entry.instr_info.instr[31]}}, head_entry.instr_info.instr[19:12], head_entry.instr_info.instr[20], head_entry.instr_info.instr[30:21], 1'b0};

    assign retire_deq_req = head_entry.status == DONE && !rob_empty && head_entry.valid;
    assign rvfi_rob_entry = head_entry_reg;
    assign branch_miss = retire_deq_req && head_entry.op == BR_UNIT && (head_entry.br_pred != head_entry.br_result);
    // head reg rd valid checked by web
    assign commit_addr_stay_renamed = (rat_entry_to_update.paddr == head_entry_reg.rd_paddr && rat_entry_to_update.renamed) ? '0 : rat_entry_to_update.renamed;

    
    always_comb begin
        head_reg_next = head_entry;
        if (branch_miss && head_entry.br_result == NOT_TAKEN) begin
            branch_target = head_entry.instr_info.pc_wdata;
            head_reg_next.instr_info.pc_wdata = head_entry.instr_info.pc_wdata;
        end else begin
            case (head_entry.instr_info.instr[6:0])
                op_b_jal  :
                    branch_target = head_entry.instr_info.pc_rdata + j_imm;
                op_b_jalr :
                    branch_target = head_entry.rs_info.rs1_data + i_imm;
                op_b_br   :
                    branch_target = head_entry.instr_info.pc_rdata + b_imm;
                default   :
                    branch_target = 'x;
            endcase 
            head_reg_next.instr_info.pc_wdata = branch_target;
        end
    end 
   

    always_ff @ (posedge clk) begin
        if (rst) begin
            head_entry_reg <= '0;
            retire_prf_web <= '0;
            retire_prf_paddr <= 'x;
        end
        else begin
            head_entry_reg <= (retire_deq_req && head_entry.op == BR_UNIT && head_entry.br_result == TAKEN) ? head_reg_next : (retire_deq_req) ? head_entry : '0;

            // Trail ARF update by 1 cycle
            if (head_entry_reg.status == DONE && head_entry_reg.instr_info.rd_valid) begin
                retire_prf_web <= '1;
                retire_prf_paddr <= head_entry_reg.rd_paddr;
            end
            else begin
                retire_prf_web <= '0;
            end
        end
    end
    
    // Free list update
    always_comb begin

        free_list_enq_enb = '0;
        freed_paddr = head_entry_reg.rd_paddr;

        // Free rd if instruction uses
        if(head_entry_reg.status == DONE && head_entry_reg.instr_info.rd_valid) begin       
            //read signals
            free_list_enq_enb = '1;
        end
    end

    // TODO Need to send paddr from committed instruction to PRF
    always_comb begin
        commit_paddr = 'x;
        commit_arf_web = '1;
        commit_rd_addr = 'x;
        // Address for reading data to send to ARF
        if(retire_deq_req) begin
            commit_paddr = head_entry.rd_paddr; 
        end
        // Info for updating ARF
        if(head_entry_reg.status == DONE && head_entry_reg.instr_info.rd_valid) begin
            commit_arf_web = (head_entry_reg.rd_addr == '0) ? '1 : '0;
            commit_rd_addr = head_entry_reg.rd_addr;   
        end
    end

endmodule
