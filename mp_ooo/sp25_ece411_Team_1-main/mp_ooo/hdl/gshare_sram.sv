module gshare_attempt 
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
    // GHR (Global History Register), stores the more recent branch results LSB is most recent
    logic [GHR_WIDTH-1:0] ghr;
    logic [GHR_WIDTH-1:0] ghr_next;
    logic [GHR_WIDTH-1:0] ghr_prev;
    logic [31:0]          pc_retire_prev;

    // Port in-out for PHT-fetch
    /* 
    PORT 1: read from the pht with ghr xor pc_fetch(low bits) to predict branch
    PORT 2: write and read to the pht with ghr xor pc_retire(low bits) to update PHT
    */
    logic [1:0] pht_fetch_csb;
    logic [1:0] pht_fetch_web;
    logic [1:0] pht_fetch_in  [2];
    logic [1:0] pht_fetch_out [2];
    logic [GHR_WIDTH-1:0] pht_fetch_addr [2];

    // Port in-out for PHT-retire
    /* 
    PORT 1: read from the pht with previous (ghr xor pc_retire(low bits)) to form correct counter din
    PORT 2: write and read to the pht with ghr xor pc_retire(low bits) to update PHT
    */
    logic [1:0] pht_retire_csb;
    logic [1:0] pht_retire_web;
    logic [1:0] pht_retire_in  [2];
    logic [1:0] pht_retire_out [2];
    logic [GHR_WIDTH-1:0] pht_retire_addr [2];

    // logic to deal with using SRAM (SRAM instantiates as dont care)
    logic [2:0] pht_valid_csb;
    logic [2:0] pht_valid_web;
    logic  pht_valid_in  [3];
    logic  pht_valid_out [3]; //1-fetch pc read, 2-pht update, 3-retire pc read
    logic [GHR_WIDTH-1:0] pht_valid_addr [3];
    assign pht_valid_csb = '0;
    assign pht_valid_in[0] = '1;
    assign pht_valid_in[1] = '1; //only write with this one
    assign pht_valid_in[2] = '1;
    assign pht_valid_addr[0] = ghr ^ pc_fetch[GHR_WIDTH-1+2:2];
    assign pht_valid_addr[1] = ghr_prev ^ pc_retire_prev[GHR_WIDTH-1+2:2];
    assign pht_valid_addr[2] = ghr ^ pc_retire[GHR_WIDTH-1+2:2]; //take updated GHR since that is instr(pc) we are retiring


    // XOR pht index computations
    assign pht_fetch_addr[0] = ghr ^ pc_fetch[GHR_WIDTH-1+2:2];
    assign pht_fetch_addr[1] = ghr_prev ^ pc_retire_prev[GHR_WIDTH-1+2:2];
    assign pht_retire_addr[0] = ghr ^ pc_retire[GHR_WIDTH-1+2:2]; //take updated GHR since that is instr(pc) we are retiring
    assign pht_retire_addr[1] = ghr_prev ^ pc_retire_prev[GHR_WIDTH-1+2:2];
 
    // pattern history table (2b saturating counters per address)
    // param_ff_array #(.NUM_PORTS(2), .S_INDEX(GHR_WIDTH), .WIDTH(2), .REGISTER_INPUTS(0)) pht (
    //     .clk(clk),         
    //     .rst(rst),        
    //     .csb(pht_csb),      
    //     .web(pht_web),     
    //     .addr(pht_addr),
    //     .din(pht_in),
    //     .dout(pht_out)
    // );

    param_ff_array #(.NUM_PORTS(3), .S_INDEX(GHR_WIDTH), .WIDTH(1), .REGISTER_INPUTS(1), .PORT_FORWARD(0)) pht_valid (
        .clk(clk),         
        .rst(rst),        
        .csb(pht_valid_csb),      
        .web(pht_valid_web),     
        .addr(pht_valid_addr),
        .din(pht_valid_in),
        .dout(pht_valid_out)
    );

    mp_ooo_pht pht_fetch (
        // Port 0: for fetch prediction
        .clk0(clk),
        .csb0(pht_fetch_csb[0]),
        .web0(pht_fetch_web[0]),
        .addr0(pht_fetch_addr[0]),
        .din0(pht_fetch_in[0]),
        .dout0(pht_fetch_out[0]),

        // Port 1: for retire update
        .clk1(clk),
        .csb1(pht_fetch_csb[1]),
        .web1(pht_fetch_web[1]),
        .addr1(pht_fetch_addr[1]),
        .din1(pht_fetch_in[1]),
        .dout1(pht_fetch_out[1])
    );

    mp_ooo_pht pht_retire (
        // Port 0: for old retire read
        .clk0(clk),
        .csb0(pht_retire_csb[0]),
        .web0(pht_retire_web[0]),
        .addr0(pht_retire_addr[0]),
        .din0(pht_retire_in[0]),
        .dout0(pht_retire_out[0]),

        // Port 1: for retire update
        .clk1(clk),
        .csb1(pht_retire_csb[1]),
        .web1(pht_retire_web[1]),
        .addr1(pht_retire_addr[1]),
        .din1(pht_retire_in[1]),
        .dout1(pht_retire_out[1])
    );

    always_ff @(posedge clk) begin
        if (rst) begin
            ghr <= '0;
            ghr_prev <= '0;
            pc_retire_prev <= '0;
        end else begin
            ghr <= ghr_next;
            ghr_prev <= ghr;
            pc_retire_prev <= pc_retire;
        end
    end

    always_comb begin
        // Defaults/things that wont change
        pht_fetch_csb = '0;
        pht_fetch_web = '1;
        pht_fetch_in[0] = '0; 
        pht_fetch_in[1] = '0; //only one that changes

        pht_retire_csb = '0;
        pht_retire_web = '1;
        pht_retire_in[0] = '0; 
        pht_retire_in[1] = '0; //only one that changes

        pht_valid_web = '1;

        // GHR update from the retire stage/rob head
        if (head_entry.instr_info.instr[6:5] == 2'b11 && head_entry.status == DONE && head_entry.valid) begin
            ghr_next[GHR_WIDTH-1:1] = ghr[GHR_WIDTH-2:0];
            ghr_next[0] = head_entry.br_result;
            pht_fetch_web[1] = '0; //enable write if head_entry is DONE and its a branch or jump
            pht_retire_web[1] = '0;
            pht_valid_web[1] = '0;
        end else begin
            ghr_next = ghr;
        end 

        // branch prediction to send to the fetch stage -- MSB of 2 b saturating counter(ie weakly or strongly taken)
        br_pred = (pc_fetch_valid && pht_valid_out[0] && pht_fetch_out[0][1]) ? TAKEN : NOT_TAKEN;

        // 2-b saturating counter input (always port since web only activates if head_entry is a complete br or jal)
        unique case (head_entry.br_result)
            TAKEN : begin
                if (!pht_valid_out[2]) begin
                    pht_fetch_in[1] = 2'b01;
                    pht_retire_in[1] = 2'b01;
                end else begin
                case (pht_retire_out[0])
                    2'b11 : pht_fetch_in[1] = 2'b11;
                    2'b10 : pht_fetch_in[1] = 2'b11;
                    2'b01 : pht_fetch_in[1] = 2'b10;
                    2'b00 : pht_fetch_in[1] = 2'b01;
                endcase
                case (pht_retire_out[0])
                    2'b11 : pht_retire_in[1] = 2'b11;
                    2'b10 : pht_retire_in[1] = 2'b11;
                    2'b01 : pht_retire_in[1] = 2'b10;
                    2'b00 : pht_retire_in[1] = 2'b01;
                endcase
                end
            end
            NOT_TAKEN : begin
                if (!pht_valid_out[2]) begin
                    pht_fetch_in[1] = 2'b00;
                    pht_retire_in[1] = 2'b00;
                end else begin
                case (pht_retire_out[0])
                    2'b11 : pht_fetch_in[1] = 2'b10;
                    2'b10 : pht_fetch_in[1] = 2'b01;
                    2'b01 : pht_fetch_in[1] = 2'b00;
                    2'b00 : pht_fetch_in[1] = 2'b00;
                endcase
                case (pht_retire_out[0])
                    2'b11 : pht_retire_in[1] = 2'b10;
                    2'b10 : pht_retire_in[1] = 2'b01;
                    2'b01 : pht_retire_in[1] = 2'b00;
                    2'b00 : pht_retire_in[1] = 2'b00;
                endcase
                end
            end
        endcase
    end

endmodule