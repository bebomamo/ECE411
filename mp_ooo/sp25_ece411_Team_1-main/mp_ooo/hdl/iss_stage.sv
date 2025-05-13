module iss_stage
import rv32i_types::*;
(
    // pkts to be issue if ready
    input rs_t arith_next,
    input rs_t mem_next,
    input rs_t br_next,
    input rs_t mul_div_next,
    // Empty signal indicate if fifo has instructions
    input rs_alu_nonempty,
    input rs_mem_nonempty,
    input rs_br_nonempty,
    input rs_mul_div_nonempty,
    // Functional unit status'
    input arith_ready,
    //input mem_ready,
    input br_ready,
    input mul_div_ready,

    // Feedback to RS
    output logic [3:0] rs_deq,          // Dequeue from reservation station
    // Forwarded to functional unit
    output logic [3:0] issue_valid,        // Tell function unit pkt is valid and can be processed

    //split lsq signals
    input logic sq_enq_ready,
    input logic lq_enq_ready,
    output logic issue_load,
    output logic issue_store,


    input  logic branch_miss
);

always_comb begin : issue_logic
    // Default, stall
    rs_deq = '0;
    issue_valid = '0;
    issue_load = '0;
    issue_store = '0;
    // Arith unit
    if (arith_next.rs1_ready && arith_next.rs2_ready && rs_alu_nonempty && arith_ready && !branch_miss) begin
        rs_deq[0] = '1;
        issue_valid[0] = '1;
    end
    // Mem unit
    if (mem_next.rs1_ready && mem_next.rs2_ready && rs_mem_nonempty && !branch_miss) begin
        if(|mem_next.w_mask && sq_enq_ready) begin
            rs_deq[1] = '1;
            issue_valid[1] = '1;
            issue_store = '1;
        end
        else if (|mem_next.r_mask && lq_enq_ready) begin
            rs_deq[1] = '1;
            issue_valid[1] = '1;
            issue_load = '1;
        end
    end
    // Branch unit
    if (br_next.rs1_ready && br_next.rs2_ready && rs_br_nonempty && br_ready && !branch_miss) begin
        rs_deq[2] = '1;
        issue_valid[2] = '1;
    end
    // Mul/Div unit
    if (mul_div_next.rs1_ready && mul_div_next.rs2_ready && rs_mul_div_nonempty && mul_div_ready && !branch_miss) begin
        rs_deq[3] = '1;
        issue_valid[3] = '1;
    end

end

endmodule : iss_stage
