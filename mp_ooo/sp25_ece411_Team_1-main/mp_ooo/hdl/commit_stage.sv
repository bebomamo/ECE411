module commit_stage
import rv32i_types::*;
(
    // inputs from the functional units
    input cdb_t             arith_cdb,
    input cdb_t             mem_cdb,
    input cdb_t             br_cdb,
    input cdb_t             mul_div_cdb,

    //output common data bus, from the selected FU
    output cdb_t            selected_cdb,

    // input from the rob_head that informs the FU that needs to commit next
    input logic [1:0]       rob_head_op,

    // output to the ROB to update status
    output logic                            wb_ready_to_commit,
    output logic [ROB_ADDR_WIDTH-1:0]  wb_rob_addr,

    // outputs to functional units 
    output logic            taking_from_alu,
    output logic            taking_from_mem,
    output logic            taking_from_br,
    output logic            taking_from_mul_div
);

logic [1:0] selector;
logic       valid_commit;

always_comb begin : cdb_selector_heuristic
    // ARITH > MEM > BR > MUL_DIV TODO: Change hierarchy to MEM as most valued
    case (rob_head_op)
        ARITH_UNIT : selector = (arith_cdb.valid) ? ARITH_UNIT : (mem_cdb.valid) ? MEM_UNIT : (br_cdb.valid) ? BR_UNIT : MUL_DIV_UNIT;
        MEM_UNIT : selector = (mem_cdb.valid) ? MEM_UNIT : (arith_cdb.valid) ? ARITH_UNIT : (br_cdb.valid) ? BR_UNIT : MUL_DIV_UNIT;
        BR_UNIT : selector = (br_cdb.valid) ? BR_UNIT : (mem_cdb.valid) ? MEM_UNIT : (arith_cdb.valid) ? ARITH_UNIT : MUL_DIV_UNIT;
        MUL_DIV_UNIT : selector = (mul_div_cdb.valid) ? MUL_DIV_UNIT : (mem_cdb.valid) ? MEM_UNIT : (arith_cdb.valid) ? ARITH_UNIT : BR_UNIT;
    endcase

    case (selector)
        ARITH_UNIT : selected_cdb = arith_cdb;
        MEM_UNIT : selected_cdb = mem_cdb;
        BR_UNIT : selected_cdb = br_cdb;
        MUL_DIV_UNIT : selected_cdb = mul_div_cdb;
    endcase
end

always_comb begin : ROB_status_update
    valid_commit = (arith_cdb.valid || mem_cdb.valid || br_cdb.valid || mul_div_cdb.valid) ? '1 : '0;
    wb_ready_to_commit = (valid_commit) ? DONE : WAIT;
    wb_rob_addr = selected_cdb.rob_addr;
end

always_comb begin : taking_signals_to_functional_units
    taking_from_alu = (valid_commit && selector == ARITH_UNIT) ? '1 : '0;
    taking_from_mem = (valid_commit && selector == MEM_UNIT) ? '1 : '0; 
    taking_from_br = (valid_commit && selector == BR_UNIT) ? '1 : '0; 
    taking_from_mul_div = (valid_commit && selector == MUL_DIV_UNIT) ? '1 : '0; 
end

endmodule : commit_stage
