module cache 
import cache_types::*;
(
    input   logic           clk,
    input   logic           rst,

    // cpu side signals, ufp -> upward facing port
    input   logic   [31:0]  ufp_addr,
    input   logic   [3:0]   ufp_rmask,
    input   logic   [3:0]   ufp_wmask,
    output  logic   [31:0]  ufp_rdata,
    input   logic   [31:0]  ufp_wdata,
    output  logic           ufp_resp,

    // memory side signals, dfp -> downward facing port
    output  logic   [31:0]  dfp_addr,
    output  logic           dfp_read,
    output  logic           dfp_write,
    input   logic   [255:0] dfp_rdata,
    output  logic   [255:0] dfp_wdata,
    input   logic           dfp_resp
);

    /* ufp input regs */
    logic           [31:0]  ufp_addr_reg;
    logic           [3:0]   ufp_rmask_reg;
    logic           [3:0]   ufp_wmask_reg;
    logic           [31:0]  ufp_wdata_reg;

    /* cache internal logic */
    state_t                 state;
    state_t                 state_next;

    logic           [3:0]   oh_miss_hit_detect;
    logic           [1:0]   plru_decision;
    logic           [1:0]   hit_decision;
    logic                   miss_detected;
    logic           [31:0]  way_data [0:3];
    logic           [2:0]   plru_change [0:3];

    logic           [22:0]  tag;
    logic           [3:0]   set_index;
    logic           [2:0]   offset_sel;

    logic                   valid_in;
    logic                   dirty_in;
    logic            [2:0]  l0_l1_l2_in;

    /* SRAM cs and we */
    logic                   csb_data; 
    logic                   csb_tag;
    logic                   csb_valid;
    logic                   csb_dirty;
    logic                   csb_plru;

    logic                   web_data [0:3];
    logic                   web_tag [0:3];
    logic                   web_valid [0:3];
    logic                   web_dirty [0:3];
    logic                   web_plru;

    /* SRAM outputs */
    logic           [255:0]  data_out [0:3];
    logic           [22:0]   tag_out  [0:3];
    logic                    valid_o  [0:3];
    logic                    dirty_o  [0:3];
    logic           [2:0]    l0_l1_l2_o;

    /* SRAM inputs */
    logic           [255:0]  SRAM_data_in;
    logic           [31:0]   SRAM_data_in_32;
    logic           [31:0]   SRAM_data_wmask;

    assign tag = ufp_addr_reg[31:9];
    assign set_index = (state == idle) ? ufp_addr[8:5] : ufp_addr_reg[8:5];
    assign offset_sel = ufp_addr_reg[4:2];

    assign SRAM_data_in_32 = ufp_wdata_reg; //this should actually work since only the part with the mask gets written into the SRAM, the rest is irrelevant

    assign SRAM_data_in = (state==allocate && dfp_resp) ? dfp_rdata : ({{224{1'b0}}, SRAM_data_in_32}) << ({5'b00000, offset_sel} << 5); //this shifting syntax may or may not work

    assign SRAM_data_wmask = (state==allocate && dfp_resp) ? '1 : ufp_wmask_reg << ({2'b00, offset_sel} << 2);

    assign oh_miss_hit_detect[0] = valid_o[0] && (tag_out[0] == tag);
    assign oh_miss_hit_detect[1] = valid_o[1] && (tag_out[1] == tag);
    assign oh_miss_hit_detect[2] = valid_o[2] && (tag_out[2] == tag);
    assign oh_miss_hit_detect[3] = valid_o[3] && (tag_out[3] == tag);

    assign way_data[0] = data_out[0][offset_sel*32 +: 32];
    assign way_data[1] = data_out[1][offset_sel*32 +: 32];
    assign way_data[2] = data_out[2][offset_sel*32 +: 32];
    assign way_data[3] = data_out[3][offset_sel*32 +: 32];

    assign plru_change[0] = {l0_l1_l2_o[2], 1'b0, 1'b0};
    assign plru_change[1] = {l0_l1_l2_o[2], 1'b1, 1'b0};
    assign plru_change[2] = {1'b0, l0_l1_l2_o[1], 1'b1};
    assign plru_change[3] = {1'b1, l0_l1_l2_o[1], 1'b1};


    generate for (genvar i = 0; i < 4; i++) begin : arrays
        mp_cache_data_array data_array (
            .clk0       (clk),
            .csb0       (csb_data),
            .web0       (web_data[i]),
            .wmask0     (SRAM_data_wmask),
            .addr0      (set_index),
            .din0       (SRAM_data_in),
            .dout0      (data_out[i])
        );
        mp_cache_tag_array tag_array (
            .clk0       (clk),
            .csb0       (csb_tag),
            .web0       (web_tag[i]),
            .addr0      (set_index),
            .din0       (tag),
            .dout0      (tag_out[i])
        );
        sp_ff_array valid_array (
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (csb_valid),
            .web0       (web_valid[i]),
            .addr0      (set_index),
            .din0       (valid_in),
            .dout0      (valid_o[i])
        );
        sp_ff_array dirty_array (
            .clk0       (clk),
            .rst0       (rst),
            .csb0       (csb_dirty),
            .web0       (web_dirty[i]),
            .addr0      (set_index),
            .din0       (dirty_in),
            .dout0      (dirty_o[i])
        );
    end endgenerate

    // for psuedo LRU
    sp_ff_array #(
        .WIDTH      (3)
    ) lru_array (
        .clk0       (clk),
        .rst0       (rst),
        .csb0       (csb_plru),
        .web0       (web_plru),
        .addr0      (set_index),
        .din0       (l0_l1_l2_in),
        .dout0      (l0_l1_l2_o)
    );

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= idle;
            ufp_addr_reg <= '0;
            ufp_rmask_reg <= '0;
            ufp_wmask_reg <= '0;
            ufp_wdata_reg <= '0;
        end else begin
            state <= state_next;
            ufp_addr_reg <= (state == idle) ? ufp_addr : ufp_addr_reg;
            ufp_rmask_reg <= (state == idle) ? ufp_rmask : ufp_rmask_reg;
            ufp_wmask_reg <= (state == idle) ? ufp_wmask : ufp_wmask_reg;
            ufp_wdata_reg <= (state == idle) ? ufp_wdata : ufp_wdata_reg;
        end
    end

    /* determine what PLRU is deciding */
    always_comb begin
        if (l0_l1_l2_o[0]) begin //Went ways 23 
            if (l0_l1_l2_o[1]) begin //Went way 1
                plru_decision = 2'b00; //evict 0
            end else begin //Went way 0
                plru_decision = 2'b01; //evict 1
            end
        end else begin //Went ways 12
            if (l0_l1_l2_o[2]) begin //Went way 3 
                plru_decision = 2'b10; //evict 2
            end else begin //Went way 2
                plru_decision = 2'b11; //evict 3
            end
        end
    end

    /* state control */
    always_comb begin
        state_next = idle;
        csb_data = '1;
        csb_tag = '1;
        csb_valid = '1;
        csb_dirty = '1;
        csb_plru = '1;
        ufp_rdata = 'x;
        ufp_resp = '0;
        dirty_in = '0;
        valid_in = '0;
        l0_l1_l2_in = '0;
        hit_decision = '0;
        miss_detected = '0;

        web_data[0] = '1;
        web_dirty[0] = '1;
        web_tag[0] = '1;
        web_valid[0] ='1; 
        web_data[1] = '1;
        web_dirty[1] = '1;
        web_tag[1] = '1;
        web_valid[1] ='1; 
        web_data[2] = '1;
        web_dirty[2] = '1;
        web_tag[2] = '1;
        web_valid[2] ='1; 
        web_data[3] = '1;
        web_dirty[3] = '1;
        web_tag[3] = '1;
        web_valid[3] ='1;
        web_plru = '1;

        dfp_read = '0;
        dfp_write = '0;
        dfp_wdata = '0;
        dfp_addr = 'x;

        case (state)
            idle     : begin
                csb_tag = '0; //always enabling these chips since oh_miss_hit_detect needs them
                csb_valid = '0;
                csb_data = '0; //allow the other ones since it shouldn't cause problems?
                csb_dirty = '0;
                csb_plru = '0;
                if (!((|ufp_rmask) || (|ufp_wmask))) begin
                    state_next = idle;
                end else begin
                    state_next = hit;
                end

            end
            hit      : begin
                csb_data = '0; //allow chips to do something
                csb_tag = '0;
                csb_valid = '0;
                csb_dirty = '0;
                csb_plru = '0;

                case (oh_miss_hit_detect) //TODO: tag_out might be 1 clock cycle misaligned with tag from reg since SRAM has addr_reg
                    hit_on_way_0 : hit_decision = 2'b00;
                    hit_on_way_1 : hit_decision = 2'b01;
                    hit_on_way_2 : hit_decision = 2'b10;
                    hit_on_way_3 : hit_decision = 2'b11;
                    total_miss   : miss_detected = '1;
                endcase
                // The cases that aren't met here are invalid and should not occur based on the logic of oh_miss_hit_detect

                if (miss_detected) begin
                    state_next = (dirty_o[plru_decision]) ? writeback : allocate;
                end else begin //some hit detected
                    state_next = idle;
                    l0_l1_l2_in = plru_change[hit_decision];
                    web_plru = '0;
                    ufp_resp = '1;
                    if (|ufp_rmask_reg) begin // (reading)
                        ufp_rdata = way_data[hit_decision];
                        web_data[hit_decision] = '1;
                        dirty_in = '0;
                        web_dirty[hit_decision] = '1;
                    end else begin // we only go to hit state if we are doing something with memory (writing)
                        ufp_rdata = 'x;
                        ufp_resp = '1;
                        web_data[hit_decision] = '0;
                        dirty_in = '1;
                        web_dirty[hit_decision] = '0;
                    end
                end
            end
            allocate : begin
                state_next = (dfp_resp) ? idle : allocate;

                csb_data = '0; //allow chip to do something
                csb_tag = '0;
                csb_valid = '0;
                csb_dirty = '0;
                csb_plru = '0;

                valid_in = '1;
                web_data[plru_decision] = (dfp_resp) ? '0 : '1;
                web_tag[plru_decision] = (dfp_resp) ? '0 : '1;
                web_valid[plru_decision] = (dfp_resp) ? '0 : '1;

                dfp_read = '1;
                dfp_addr = {ufp_addr_reg[31:5], 5'b00000};
            end
            writeback: begin
                state_next = (dfp_resp) ? allocate : writeback;

                csb_data = '0; //allow chip to do something
                csb_tag = '0;
                csb_valid = '0;
                csb_dirty = '0;
                csb_plru = '0;

                dirty_in = '0;
                web_dirty[plru_decision] = (dfp_resp) ? '0 : '1;

                dfp_write = '1;
                dfp_addr = {tag_out[plru_decision], set_index, 5'b00000};
                dfp_wdata = data_out[plru_decision];
            end
        endcase
    end

endmodule
