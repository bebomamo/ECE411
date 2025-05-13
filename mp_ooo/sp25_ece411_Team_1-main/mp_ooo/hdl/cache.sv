module cache
#(
    parameter WAY               = 4,                // Number of ways, ***supported sizes: [1, 2, 4, 8]***
    parameter SETS              = 16                // Number of sets, ***change config file***
)
(
    // Clock Interface
    input   logic                       clk,
    input   logic                       rst,

    // Cpu side signals, ufp -> upward facing port
    input   logic   [31:0]              ufp_addr,
    input   logic   [3:0]               ufp_rmask,
    input   logic   [3:0]               ufp_wmask,
    output  logic   [255:0]             ufp_rdata,
    input   logic   [31:0]              ufp_wdata,
    output  logic                       ufp_resp,

    // Memory side signals, dfp -> downward facing port
    output  logic   [31:0]              dfp_addr,
    output  logic                       dfp_read,
    output  logic                       dfp_write,
    input   logic   [255:0]             dfp_rdata,
    output  logic   [255:0]             dfp_wdata,
    input   logic                       dfp_resp,

    // Optimization signals
    input   logic                       stop_req,        // Allows early allocate exit
    input   logic                       bmem_rvalid      // Prevents cancelled allocate to not miss-align with the burst memory
);

    localparam LEVELS = $clog2(WAY);
    localparam PLRU_SIZE = WAY-1;
    localparam SET_ADDR = $clog2(SETS);
    localparam OFFSET_ADDR = 5;
    localparam TAG_ADDR = 32 - SET_ADDR - OFFSET_ADDR;

    // State Defitions
    typedef enum logic [1:0] {
        s_idle          = 2'b00,
        s_hit           = 2'b01,
        s_allocate      = 2'b10,
        s_writeback     = 2'b11
    } state_t;

    logic [LEVELS-1:0] update_way, lru_way;
    
    // Cache signals, unique per way
    logic                   cache_web       [WAY];    // write enable per way, data 
    logic [31:0]            cache_wmask     [WAY];    // wmask per way
    logic [255:0]           cacheline_din   [WAY];    // din per way, cache lines data 
    logic [255:0]           cacheline_dout  [WAY];    // dout per way, cache lines data

    logic                   tag_web         [WAY];
    logic [TAG_ADDR-1:0]    tag_din         [WAY];    // din per way, tags
    logic [TAG_ADDR-1:0]    tag_dout        [WAY];    // dout per way, tags
    
    logic                   valid_web       [WAY];
    logic                   valid_din       [WAY];    // din per way, valid
    logic                   valid_dout      [WAY];    // dout per way, valid

    logic                   dirty_web       [WAY];
    logic                   dirty_din       [WAY];    // din per way, dirty
    logic                   dirty_dout      [WAY];    // dout per way, dirty

    // PLRU signals, shared accross ways
    logic                     plru_web;
    logic [PLRU_SIZE-1:0]     plru_din;
    logic [PLRU_SIZE-1:0]     plru_dout;


    // logic
    state_t                 state, next_state;
    logic [LEVELS-1:0]    hit_way;
    logic [TAG_ADDR-1:0]    tag;
    logic [SET_ADDR-1:0]    set;
    logic [SET_ADDR-1:0]    index;
    logic [OFFSET_ADDR-1:0] offset;
    logic                   hit;

    // Registers
    logic [31:0]            addr_reg;
    logic [31:0]            wdata_reg;
    logic [3:0]             wmask_reg;
    logic [3:0]             rmask_reg;
    logic                   stop_req_reg;

    // Indexing Logic
    assign tag      = addr_reg[SET_ADDR+OFFSET_ADDR +: TAG_ADDR];
    assign set      = addr_reg[OFFSET_ADDR +: SET_ADDR];
    assign offset   = addr_reg[OFFSET_ADDR-1:0];
    assign index    = (state == s_idle) ? ufp_addr[OFFSET_ADDR +: SET_ADDR] : set;

    always_ff @(posedge clk) begin  : state_update
        if (rst)
            state <= s_idle;
        else begin
            state <= next_state;
        end
    end

    always_ff @(posedge clk) begin : registers
        if (rst) begin
            addr_reg <= '0;
            wdata_reg <= '0;
            wmask_reg <= '0;
            rmask_reg <= '0;
            stop_req_reg <= '0;
        end
        else if (state == s_idle) begin
            addr_reg <= ufp_addr;
            wdata_reg <= ufp_wdata;
            wmask_reg <= ufp_wmask;
            rmask_reg <= ufp_rmask;
            stop_req_reg <= '0;
        end
        else if (stop_req)
            stop_req_reg <= '1;
        else if (dfp_resp)
            stop_req_reg <= '0;
    end

    always_comb begin : control_signals
        // Default values
        next_state = s_idle;
        hit_way = 'x;
        ufp_rdata = 'x;
        ufp_resp = '0;
        dfp_write = '0;
        dfp_read = '0;
        dfp_wdata = 'x;
        plru_web = '0;
        dfp_addr = '0;
        update_way = 'x;
        hit = '0;
        
        for (integer unsigned i = 0; i < WAY; i++) begin
            cacheline_din[i] = 'x;
            valid_din[i] = 'x;
            tag_din[i] = 'x;
            dirty_din[i] = 'x;
            cache_wmask[i] = '0;
            cache_web[i] = '0;
            dirty_web[i] = '0;
            valid_web[i] = '0;
            tag_web[i] = '0;
        end

        case (state)
            // 1 cycle need for memory to be ready
            s_idle:     begin
                // Move states if cpu requests
                next_state = ((|ufp_wmask || |ufp_rmask) && !stop_req) ? s_hit : s_idle;
            end
            s_hit:      begin
                // Check for matching tag, should never be same tag in set
                for (integer unsigned way = 0; way < WAY; way++) begin
                    if (tag == tag_dout[way] && valid_dout[way] == '1) begin
                        hit_way = LEVELS'(way);
                        hit = '1;
                    end
                end
            
                // Cancel Request
                if (stop_req)
                    next_state = s_idle;
                // Hit
                else if (hit) begin
                    plru_web = '1;
                    update_way = hit_way;
                    ufp_resp = '1;

                    // Read case
                    if (|rmask_reg) begin
                        next_state = s_idle;
                        // cpu handles read mask
                        ufp_rdata = cacheline_dout[hit_way];
                    end
                    // Write case
                    if (|wmask_reg) begin
                        next_state = s_idle;
                        dirty_din[hit_way] = '1;
                        dirty_web[hit_way] = '1;
                        cache_web[hit_way] = '1;
                        // assign the new word to the old
                        cacheline_din[hit_way][offset[4:2] * 32 +: 32] = wdata_reg;
                        // The wmask will preserve the data 
                        cache_wmask[hit_way] = 32'b0;
                        cache_wmask[hit_way][offset[4:2]*4 +: 4] = wmask_reg;
                    end
                end
                // Check for clean or dirty miss
                else begin
                    next_state = (dirty_dout[lru_way]) ? s_writeback : s_allocate;
                end
            end
            s_writeback:    begin
                dfp_write = '1;
                dfp_wdata = cacheline_dout[lru_way];
                dfp_addr = {tag_dout[lru_way], set, {OFFSET_ADDR{1'b0}}};  // Set should match with current CPU addr, the rest is reconstructed
                next_state = s_writeback;
                // Stall until write recieved
                if (dfp_resp) begin
                    dirty_web[lru_way] = '1;
                    dirty_din[lru_way] = '0;
                    next_state = (stop_req_reg) ? s_idle : s_allocate;
                end
            end
            s_allocate:     begin
                dfp_read = '1;
                next_state = s_allocate;
                dfp_addr = {tag, set, {OFFSET_ADDR{1'b0}}};
                // Stall until data comes 
                if (dfp_resp) begin
                    cache_web[lru_way] = '1;
                    cacheline_din[lru_way] = dfp_rdata;
                    cache_wmask[lru_way] = '1;
                    tag_web[lru_way] = '1;
                    tag_din[lru_way] = tag;
                    valid_web[lru_way] = '1;
                    valid_din[lru_way] = '1;
                    next_state = s_idle;
                end
                else if (stop_req && !bmem_rvalid)
                    next_state = s_idle;
            end
            default:
                next_state = s_idle;
        endcase
    end

    generate
        if (WAY == 1) begin
            // 1-node tree 
            assign plru_din = '0;
            assign lru_way = '0;
        end
        else if (WAY == 2) begin
            always_comb begin
                // 2-node tree
                case (update_way)
                    1'd0: plru_din = 1'b0; 
                    1'd1: plru_din = 1'b1;
                    default : plru_din = 'x;
                endcase
                case (plru_dout)
                    1'b1: lru_way = 1'b0; 
                    1'b0: lru_way = 1'b1;
                endcase
            end
        end
        else if (WAY == 4) begin
            always_comb begin
                // 3-node tree
                case (update_way)
                    2'd0: plru_din = {plru_dout[2], 1'b0, 1'b0};
                    2'd1: plru_din = {plru_dout[2], 1'b1, 1'b0};
                    2'd2: plru_din = {1'b0, plru_dout[1], 1'b1};
                    2'd3: plru_din = {1'b1, plru_dout[1], 1'b1};
                endcase
                casez (plru_dout)
                    3'b?11  :   lru_way = 2'b00;
                    3'b?01  :   lru_way = 2'b01;
                    3'b1?0  :   lru_way = 2'b10;
                    3'b0?0  :   lru_way = 2'b11;
                    // Should never happen as cases covered
                    default : lru_way = 'x;
                endcase
            end
        end
        else if (WAY == 8) begin
            always_comb begin
                // 7-node tree
                case (update_way)
                    3'd0: plru_din = {plru_dout[6], plru_dout[5], plru_dout[4], 1'b0, plru_dout[2], 1'b0, 1'b0};
                    3'd1: plru_din = {plru_dout[6], plru_dout[5], plru_dout[4], 1'b1, plru_dout[2], 1'b0, 1'b0};
                    3'd2: plru_din = {plru_dout[6], plru_dout[5], 1'b0, plru_dout[3], plru_dout[2], 1'b0, 1'b0};
                    3'd3: plru_din = {plru_dout[6], plru_dout[5], 1'b1, plru_dout[3], plru_dout[2], 1'b0, 1'b0};
                    3'd4: plru_din = {plru_dout[6], 1'b0, plru_dout[4], plru_dout[3], 1'b0, plru_dout[1], 1'b1};
                    3'd5: plru_din = {plru_dout[6], 1'b1, plru_dout[4], plru_dout[3], 1'b0, plru_dout[1], 1'b1};
                    3'd6: plru_din = {1'b0, plru_dout[5], plru_dout[4], plru_dout[3], 1'b1, plru_dout[1], 1'b1};
                    3'd7: plru_din = {1'b1, plru_dout[5], plru_dout[4], plru_dout[3], 1'b1, plru_dout[1], 1'b1};
                endcase
                casez (plru_dout) 
                    7'b???1?11  : lru_way = 3'd0;
                    7'b???0?11  : lru_way = 3'd1;
                    7'b??1??01  : lru_way = 3'd2;
                    7'b??0??01  : lru_way = 3'd3;
                    // right half subtree
                    7'b?1??1?0  : lru_way = 3'd4;
                    7'b?0??1?0  : lru_way = 3'd5;
                    7'b1???0?0  : lru_way = 3'd6;
                    7'b0???0?0  : lru_way = 3'd7;
                    default     : lru_way = 'x;
                endcase
            end  
        end
    endgenerate

    generate 
        for (genvar way = 0; way < WAY; way++) begin : arrays
            if (SETS == 16) begin
                mp_ooo_data_array_16addr data_array (
                    .clk0       (clk),
                    .csb0       ('0),
                    .web0       (~cache_web[way]),
                    .wmask0     (cache_wmask[way]),
                    .addr0      (index),
                    .din0       (cacheline_din[way]),
                    .dout0      (cacheline_dout[way])
                );
                mp_ooo_tag_array_16addr tag_array (
                    .clk0       (clk),
                    .csb0       ('0),
                    .web0       (~tag_web[way]),
                    .addr0      (index),
                    .din0       (tag_din[way]),
                    .dout0      (tag_dout[way])
                );
                sp_ff_array #( 
                    .WIDTH(1),
                    .S_INDEX(SET_ADDR) 
                ) valid_array (
                    .clk0       (clk),
                    .rst0       (rst),
                    .csb0       ('0),
                    .web0       (~valid_web[way]),
                    .addr0      (index),
                    .din0       (valid_din[way]),
                    .dout0      (valid_dout[way])
                );
                sp_ff_array #( 
                    .WIDTH(1),
                    .S_INDEX(SET_ADDR) 
                ) dirty_array (
                    .clk0       (clk),
                    .rst0       (rst),
                    .csb0       ('0),
                    .web0       (~dirty_web[way]),
                    .addr0      (index),
                    .din0       (dirty_din[way]),
                    .dout0      (dirty_dout[way])
                );
            end
            else if (SETS == 32) begin
                mp_ooo_data_array_32addr data_array (
                    .clk0       (clk),
                    .csb0       ('0),
                    .web0       (~cache_web[way]),
                    .wmask0     (cache_wmask[way]),
                    .addr0      (index),
                    .din0       (cacheline_din[way]),
                    .dout0      (cacheline_dout[way])
                );
                mp_ooo_tag_array_32addr tag_array (
                    .clk0       (clk),
                    .csb0       ('0),
                    .web0       (~tag_web[way]),
                    .addr0      (index),
                    .din0       (tag_din[way]),
                    .dout0      (tag_dout[way])
                );
                sp_ff_array #( 
                    .WIDTH(1),
                    .S_INDEX(SET_ADDR) 
                ) valid_array (
                    .clk0       (clk),
                    .rst0       (rst),
                    .csb0       ('0),
                    .web0       (~valid_web[way]),
                    .addr0      (index),
                    .din0       (valid_din[way]),
                    .dout0      (valid_dout[way])
                );
                sp_ff_array #( 
                    .WIDTH(1),
                    .S_INDEX(SET_ADDR) 
                ) dirty_array (
                    .clk0       (clk),
                    .rst0       (rst),
                    .csb0       ('0),
                    .web0       (~dirty_web[way]),
                    .addr0      (index),
                    .din0       (dirty_din[way]),
                    .dout0      (dirty_dout[way])
                );
            end
            else if (SETS == 64) begin
                mp_ooo_data_array_16addr data_array (
                    .clk0       (clk),
                    .csb0       ('0),
                    .web0       (~cache_web[way]),
                    .wmask0     (cache_wmask[way]),
                    .addr0      (index),
                    .din0       (cacheline_din[way]),
                    .dout0      (cacheline_dout[way])
                );
                mp_ooo_tag_array_16addr tag_array (
                    .clk0       (clk),
                    .csb0       ('0),
                    .web0       (~tag_web[way]),
                    .addr0      (index),
                    .din0       (tag_din[way]),
                    .dout0      (tag_dout[way])
                );
                sp_ff_array #( 
                    .WIDTH(1),
                    .S_INDEX(SET_ADDR) 
                ) valid_array (
                    .clk0       (clk),
                    .rst0       (rst),
                    .csb0       ('0),
                    .web0       (~valid_web[way]),
                    .addr0      (index),
                    .din0       (valid_din[way]),
                    .dout0      (valid_dout[way])
                );
                sp_ff_array #( 
                    .WIDTH(1),
                    .S_INDEX(SET_ADDR)
                ) dirty_array (
                    .clk0       (clk),
                    .rst0       (rst),
                    .csb0       ('0),
                    .web0       (~dirty_web[way]),
                    .addr0      (index),
                    .din0       (dirty_din[way]),
                    .dout0      (dirty_dout[way])
                );
            end
        end 
    endgenerate

    // Array for handling replacement policy
    sp_ff_array #(
        .WIDTH      (PLRU_SIZE),
        .S_INDEX    (SET_ADDR)
    ) plru_array (
        .clk0       (clk),
        .rst0       (rst),
        .csb0       ('0),
        .web0       (~plru_web),
        .addr0      (index),
        .din0       (plru_din),
        .dout0      (plru_dout)
    );

endmodule
