module if_stage
import rv32i_types::*;
(
    input   logic               clk,
    input   logic               rst,
    input   logic   [255:0]     imem_rdata,     // Cacheline from IM cache
    input   logic               imem_resp,      // resp signal indicates response from cache
    output  logic   [31:0]      imem_addr,      // IM address to request
    output  logic   [3:0]       imem_rmask,     // IM read mask for request
    input   logic               branch_miss,    // Need a flush
    input   logic   [31:0]      branch_target,  // New PC
    output  instr_t             if_id_stage_reg_next,
    output  logic   [4:0]       rs1_addr,
    output  logic   [4:0]       rs2_addr,
    input   logic               dis_stall,
    input   logic               br_pred,
    output  logic   [31:0]      pc_reg_out,
    output  logic               pc_reg_out_valid,
    output  logic               im_cache_stop_req
);

localparam FIFO_WIDTH = $bits(fetch_pkt_t);
// Registers
logic [31:0] pc_reg;
logic [255:0] linebuffer_reg;
logic [2:0] counter_reg;
valid_t valid_reg;
logic [3:0] rmask_reg;

// Prefetch buffer
logic [255:0] pf_linebuffer_reg;
valid_t pf_valid;
logic pf_pending;
logic [31:0] pf_addr;
logic [3:0] pf_rmask;


// Next address/mask before driving outputs
logic [31:0] next_imem_addr;
logic [3:0]  next_imem_rmask;

// Local Logic Variables
logic [31:0] pc_next;
logic im_req_inp;

logic enq_req;
logic [FIFO_WIDTH-1:0] enq_data;
logic enq_ready;
logic deq_req;
logic [FIFO_WIDTH-1:0] deq_data;
logic deq_ready;
fetch_pkt_t deq_pkt;
logic near_empty;

// IM FIFO
fifo #(.WIDTH(FIFO_WIDTH), .DEPTH(16)) im_fifo
(
    .clk(clk),
    .rst(rst | branch_miss),
    .enq_req(enq_req),
    .enq_data(enq_data),
    .enq_ready(enq_ready),
    .deq_req(deq_req),
    .deq_data(deq_data),
    .deq_ready(deq_ready),
    .near_empty(near_empty)
);

logic  branch_target_waiting;
logic  [31:0] branch_target_reg;
logic  [31:0] linebuffer_base_pc_reg;
assign pc_reg_out = pc_reg;
assign pc_reg_out_valid = (deq_req) ? VALID : INVALID;

// Combinational: choose next PC, prefetch, or branch target
always_comb begin
    // Both prefetch and linebuffer have data, no need to request (branch_miss is edge case)
    if (valid_reg && pf_valid) begin
        next_imem_addr = pc_reg;
        next_imem_rmask = (branch_miss) ? rmask_reg : 4'b0;
    end
    // PF is enabled and can process prefetch request 
    else if (pf_pending) begin
        next_imem_addr = pf_addr;
        next_imem_rmask = rmask_reg;
    end
    // PF is not enabled and need to read from PC, otherwise branch is handled here too (branch turns off PF)
    else begin
        next_imem_addr  = pc_reg;
        next_imem_rmask = rmask_reg;
    end

    if (branch_miss && (branch_target[31:5] != imem_addr[31:5]))
        im_cache_stop_req = '1;
    else
        im_cache_stop_req = '0;
end

// Drive outputs
assign imem_addr  = next_imem_addr;
assign imem_rmask = next_imem_rmask;
assign im_req_inp = |imem_rmask;
assign pc_next    = pc_reg + 4;
assign rs1_addr   = (deq_ready) ? deq_pkt.instr[19:15] : '0;
assign rs2_addr   = (deq_ready) ? deq_pkt.instr[24:20] : '0;
assign deq_pkt    = deq_data;

// Response handling
always_ff @(posedge clk) begin
    if (rst) begin
        pc_reg <= 32'hAAAAA000;
        linebuffer_reg <= '0;
        counter_reg <= '0;
        valid_reg <= INVALID;
        rmask_reg <= '1;
        pf_valid <= INVALID;
        pf_pending <= 1'b0;
        branch_target_waiting <= 1'b0;
        linebuffer_base_pc_reg <= '0;
    end
    else if (branch_miss) begin
        valid_reg <= INVALID;       // Mark buffer invalid, meaning we do not want to enqueue
        pf_valid <= INVALID;        // Mark pf buffer invalid;
        counter_reg <= branch_target[4:2];
        branch_target_reg <= branch_target;
        // Check if IM read in progress (blocking cache) 
        // if (im_req_inp)
        //     branch_target_waiting <= '1; 
        // else
        pc_reg <= branch_target;
        pf_pending <= '0;
    end
    else begin
        // Handle Cache Response
        if (imem_resp) begin
            // Handle branch if request was in progress during true miss (skip 1 resp)
            // if (branch_target_waiting) begin
            //     branch_target_waiting <= 1'b0;
            //     pc_reg <= branch_target_reg;
            //     pf_pending <= '0;
            // end
            // Update linebuffer
            if (!valid_reg) begin
                // main fetch response
                linebuffer_reg <= imem_rdata;
                valid_reg <= VALID;
                // issue prefetch
                pf_addr <= pc_reg + 'd32;
                pf_pending <= 1'b1;
                linebuffer_base_pc_reg <= imem_addr;
            end
            // Store prefetched buffer if still waiting on linebuffer
            else if (pf_pending && !pf_valid) begin
                // prefetch response
                pf_linebuffer_reg <= imem_rdata;
                pf_valid <= VALID;
                pf_addr <= pf_addr + 'd32;
            end
        end

        // Handle parsing buffer and prefectch swap if available

        if (enq_ready) begin
            if ( (valid_reg && pf_valid && counter_reg == 3'd7) || (pf_valid && !valid_reg) ) begin
                // swap prefetch into main if ready
                linebuffer_reg <= pf_linebuffer_reg;
                valid_reg <= VALID;
                counter_reg <= '0;
                pc_reg <= (valid_reg) ? pc_next : pc_reg;
                // next prefetch
                pf_pending <= 1'b1;
                pf_valid <= INVALID;
            end
            else if (valid_reg) begin
                if (counter_reg == 3'd7) begin
                    valid_reg <= INVALID;
                    counter_reg <= '0;
                    pc_reg <= pc_next;
                end
                else begin
                    counter_reg <= counter_reg + 3'd1;
                    pc_reg <= pc_next;
                end 
            end
        end
        else if (pf_valid && !valid_reg) begin
            linebuffer_reg <= pf_linebuffer_reg;
            valid_reg <= VALID;
            counter_reg <= '0;
            pc_reg <= pc_reg;
            pf_pending <= '1;
            pf_valid <= INVALID;
        end

    end
end

// FIFO enqueue/dequeue
always_comb begin
    enq_req = 1'b0;
    deq_req = 1'b0;
    enq_data = '0;

    if (valid_reg && enq_ready) begin
        enq_req = 1'b1;
        enq_data = {linebuffer_reg[32*counter_reg +: 32], pc_reg, pc_next};
    end
    if (deq_ready && !dis_stall)
        deq_req = 1'b1;
end

// Output to IF/ID stage
always_comb begin
    if_id_stage_reg_next = '0;
    if_id_stage_reg_next.instr    = deq_pkt.instr;
    if_id_stage_reg_next.pc_rdata = deq_pkt.pc_rdata;
    if_id_stage_reg_next.pc_wdata = deq_pkt.pc_wdata;
    if_id_stage_reg_next.valid    = (deq_req) ? VALID : INVALID;
    if_id_stage_reg_next.br_pred  = (if_id_stage_reg_next.instr[6:0] == op_b_jalr) ? NOT_TAKEN : (if_id_stage_reg_next.instr[6:0] == op_b_jal) ? TAKEN : taken_t'(br_pred);
end

endmodule : if_stage
