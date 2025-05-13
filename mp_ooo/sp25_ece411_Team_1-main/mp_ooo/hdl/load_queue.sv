module load_queue 
import rv32i_types::*;
#(
    parameter WIDTH = 32,
    parameter DEPTH = 8
)(
    input  logic                 clk,
    input  logic                 rst,

    input logic                 enq_req,
    input lsq_t               enq_data,
    output logic                enq_ready,

    input logic                 deq_req,
    output lsq_t              deq_data,
    output logic                deq_ready,
    input logic [ROB_ADDR_WIDTH-1:0] rob_head,

    output logic deq_data_ready,
    input logic [SQ_ADDR_WIDTH:0] store_count,              //hard coded size
    input logic [ROB_ADDR_WIDTH-1:0] store_head_age,
    input logic [ROB_ADDR_WIDTH-1:0] store_tail_age,

    input logic [SQ_DEPTH-1:0]                        store_valid,
    input logic [SQ_DEPTH-1:0][31:0]                  store_address,
    input logic [SQ_DEPTH-1:0][ROB_ADDR_WIDTH-1:0]    store_rob_addr

);

    localparam ADDR_WIDTH = $clog2(DEPTH);


    lsq_t mem[DEPTH];
    logic valid[DEPTH];
    
    logic [ADDR_WIDTH:0] count;
    logic [ADDR_WIDTH-1:0] free_idx, oldest_idx;
    logic [ROB_ADDR_WIDTH-1:0] oldest_age, current_age;
    logic found_free;

    logic [ROB_ADDR_WIDTH-1:0] store_age, load_age;
    logic blocked;
    logic                        ready_load_found;
    logic [ADDR_WIDTH-1:0]       ready_load_idx;
    logic lq_head_ready;

    assign enq_ready = found_free;
    assign deq_ready = (count > '0);
    assign deq_data = (deq_ready) ? (lq_head_ready ? mem[oldest_idx] : (ready_load_found ? mem[ready_load_idx] : '0)) : '0;
    assign deq_data_ready = lq_head_ready || ready_load_found;



    always_comb begin
        found_free = '0;
        free_idx = '0;
        oldest_idx = '0;
        oldest_age = '1;
        current_age = '0;
        for (integer unsigned i = 0; i < DEPTH; i++) begin
            if (!valid[i]) begin
                found_free = '1;
                free_idx = ADDR_WIDTH'(i);
                break;
            end
        end
        for (integer unsigned i = 0; i < DEPTH; i++) begin
            if(valid[i]) begin
                current_age = (mem[i].rob_addr >= rob_head) ? (mem[i].rob_addr - rob_head) : (5'd31- rob_head + mem[i].rob_addr);
                if (current_age < oldest_age) begin
                    oldest_idx = ADDR_WIDTH'(i);
                    oldest_age = current_age;
                end
            end
        end
    end


    always_comb begin
        load_age = '0;
        store_age = '0;
        blocked = '0;
        ready_load_found = '0;
        ready_load_idx = '0;
        if (store_count == 0) begin
            lq_head_ready = 1'b1;
        end
        else if ((oldest_age < store_head_age)) begin
            lq_head_ready = 1'b1;
        end
        else begin
            lq_head_ready = 1'b0;
            // Search for a non-aliasing load
            for (integer unsigned i = 0; i < DEPTH; i++) begin
                if (valid[i]) begin
                    load_age = (mem[i].rob_addr >= rob_head) ? (mem[i].rob_addr - rob_head) : (5'd31 - rob_head + mem[i].rob_addr);
                    blocked = '0;
                    if(store_tail_age < load_age) begin
                        blocked = '1;
                    end
                    else begin
                        for (integer unsigned j = 0; j < DEPTH; j++) begin
                            if (store_valid[j]) begin
                                store_age = (store_rob_addr[j] >= rob_head) ? (store_rob_addr[j] - rob_head) : (5'd31 - rob_head + store_rob_addr[j]);
                                if (store_age < load_age && store_address[j] == mem[i].address) begin
                                    blocked = '1;
                                end
                            end
                        end
                    end

                    if (!blocked && !ready_load_found) begin
                        ready_load_found = 1'b1;
                        ready_load_idx   = ADDR_WIDTH'(i);
                    end
                end
            end
        end
    end


    always_ff @ (posedge clk) begin
        if(rst) begin
            count <= '0;
            for (integer i = 0; i < DEPTH; i++) begin
                valid[i] <= '0;
            end
        end
        else begin
            if(enq_req && enq_ready) begin
                mem[free_idx] <= enq_data;
                count <= (deq_req) ? count : count + 1'b1;
                valid[free_idx] <= '1;
            end
            if (deq_ready && deq_req) begin
                if (lq_head_ready) begin
                    valid[oldest_idx] <= 1'b0;
                end else if (ready_load_found) begin
                    valid[ready_load_idx] <= 1'b0;
                end
                count <= (enq_req) ? count : count - 1'b1;
            end
        end
    end



endmodule
