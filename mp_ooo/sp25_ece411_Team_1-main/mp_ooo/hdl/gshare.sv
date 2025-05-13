module gshare 
import rv32i_types::*;
#(
    parameter GHR_WIDTH = 4
)
(
    input  logic                            clk,
    input  logic                            rst,
    input  logic  [31:0]                    pc_fetch,
    input  logic                            pc_fetch_valid,
    input  logic  [31:0]                    pc_retire,

    input  rob_t                            head_entry,
    output taken_t                          br_pred                            
);
    // Internal logics:
    // Port in-out for PHT
    /* 
    PORT 1: read from the pht with ghr xor pc(low bits) to predict branch
    PORT 2: write to the pht with ghr_next xor pc(low bits) AGAIN to predict branch
    PORT 3: read from the pht with ghr xor pc(low bits) to update sat counter
    */
    logic [2:0] pht_csb;
    logic [2:0] pht_web;
    logic [1:0] pht_in  [3];
    logic [1:0] pht_out [3];
    logic [GHR_WIDTH-1:0] pht_addr [3];

    // GHR (Global History Register), stores the more recent branch results LSB is most recent
    logic [GHR_WIDTH-1:0] ghr;
    logic [GHR_WIDTH-1:0] ghr_next;

    // XOR pht index computations
    assign pht_addr[0] = ghr ^ pc_fetch[GHR_WIDTH-1+2:2];
    assign pht_addr[1] = ghr ^ pc_retire[GHR_WIDTH-1+2:2]; //take updated GHR since that is instr(pc) we are retiring
    assign pht_addr[2] = ghr ^ pc_retire[GHR_WIDTH-1+2:2];
 
    // pattern history table (2b saturating counters per address)
    param_ff_array #(.NUM_PORTS(3), .S_INDEX(GHR_WIDTH), .WIDTH(2), .REGISTER_INPUTS(0)) pht (
        .clk(clk),         
        .rst(rst),        
        .csb(pht_csb),      
        .web(pht_web),     
        .addr(pht_addr),
        .din(pht_in),
        .dout(pht_out)
    );

    always_ff @(posedge clk) begin
        if (rst) begin
            ghr <= '0;
        end else begin
            ghr <= ghr_next;
        end
    end

    always_comb begin
        // Defaults/things that wont change
        pht_csb = '0;
        pht_web = '1;
        pht_in[0] = '0; 
        pht_in[1] = '0; //only one that changes
        pht_in[2] = '0;

        // GHR update from the retire stage/rob head
        if (head_entry.instr_info.instr[6:5] == 2'b11 && head_entry.status == DONE && head_entry.valid) begin
            ghr_next[GHR_WIDTH-1:1] = ghr[GHR_WIDTH-2:0];
            ghr_next[0] = head_entry.br_result;
            pht_web[1] = '0; //enable write if head_entry is DONE and its a branch or jump
        end else begin
            ghr_next = ghr;
        end 

        // branch prediction to send to the fetch stage -- MSB of 2 b saturating counter(ie weakly or strongly taken)
        br_pred = (pc_fetch_valid && pht_out[0][1]) ? TAKEN : NOT_TAKEN;

        // 2-b saturating counter input (always port since web only activates if head_entry is a complete br or jal)
        unique case (head_entry.br_result)
            TAKEN : begin
                case (pht_out[2])
                    2'b11 : pht_in[1] = 2'b11;
                    2'b10 : pht_in[1] = 2'b11;
                    2'b01 : pht_in[1] = 2'b10;
                    2'b00 : pht_in[1] = 2'b01;
                endcase
            end
            NOT_TAKEN : begin
                case (pht_out[2])
                    2'b11 : pht_in[1] = 2'b10;
                    2'b10 : pht_in[1] = 2'b01;
                    2'b01 : pht_in[1] = 2'b00;
                    2'b00 : pht_in[1] = 2'b00;
                endcase
            end
        endcase
    end

endmodule