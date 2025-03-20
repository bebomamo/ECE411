module cache_wo_way_data 
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

    /* cache internal logic */
    logic           [1:0]   state;
    logic           [1:0]   state_next;

    logic           [3:0]   oh_miss_hit_detect;
    logic           [1:0]   plru_decision;
    logic           [1:0]   hit_decision;

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

    assign tag = ufp_addr[31:9];
    assign set_index = ufp_addr[8:5];
    assign offset_sel = ufp_addr[4:2];

    // assign SRAM_data_in_32[31:24] = (ufp_wmask[3]) ? ufp_wdata[31:24] : data_out[hit_decision][offset_sel*32+31:offset_sel*32+24];
    // assign SRAM_data_in_32[23:16] = (ufp_wmask[2]) ? ufp_wdata[23:16] : data_out[hit_decision][offset_sel*32+23:offset_sel*32+16];
    // assign SRAM_data_in_32[15:8] = (ufp_wmask[1]) ? ufp_wdata[15:8] : data_out[hit_decision][offset_sel*32+15:offset_sel*32+8];
    // assign SRAM_data_in_32[7:0] = (ufp_wmask[0]) ? ufp_wdata[7:0] : data_out[hit_decision][offset_sel*32+7:offset_sel*32];
    assign SRAM_data_in_32 = ufp_wdata; //this should actually work since only the part with the mask gets written into the SRAM, the rest is irrelevant

    // assign SRAM_data_in = (state==allocate && dfp_resp) ? dfp_rdata : ({{224{1'b0}}, SRAM_data_in_32}) << (offset_sel * 32); //this shifting syntax may or may not work
    assign SRAM_data_in = (state==allocate && dfp_resp) ? dfp_rdata : ({{224{1'b0}}, SRAM_data_in_32}) << (offset_sel << 5); //this shifting syntax may or may not work


    // assign SRAM_data_wmask = ({28'h0000000, ufp_wmask}) << (offset_sel * 4); //again might not work
    assign SRAM_data_wmask = ufp_wmask << (offset_sel << 2);

    assign oh_miss_hit_detect[0] = valid_o[0] && (tag_out[0] == tag);
    assign oh_miss_hit_detect[1] = valid_o[1] && (tag_out[1] == tag);
    assign oh_miss_hit_detect[2] = valid_o[2] && (tag_out[2] == tag);
    assign oh_miss_hit_detect[3] = valid_o[3] && (tag_out[3] == tag);


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
            state <= '0;
        end else begin
            state <= state_next;
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
        hit_decision = '0; //wont matter
        ufp_rdata = 'x;
        ufp_resp = '0;
        dirty_in = '0;
        valid_in = '0;
        l0_l1_l2_in = '0;

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
                if (!((|ufp_rmask) || (|ufp_wmask))) begin
                    state_next = idle;
                    csb_data = '1;
                    csb_tag = '1;
                    csb_valid = '1;
                    csb_dirty = '1;
                    csb_plru = '1;
                end else begin
                    state_next = hit;
                    csb_data = '0;
                    csb_tag = '0;
                    csb_valid = '0;
                    csb_dirty = '0;
                    csb_plru = '0;
                end
            end
            hit      : begin
                csb_data = '0; //allow chip to do something
                csb_tag = '0;
                csb_valid = '0;
                csb_dirty = '0;
                csb_plru = '0;

                unique case (oh_miss_hit_detect) //detector is completed with assign statements
                    hit_on_way_0 : begin
                        state_next = idle;
                        hit_decision = 2'b00;
                        l0_l1_l2_in[0] = '0;
                        l0_l1_l2_in[1] = '0;
                        l0_l1_l2_in[2] = l0_l1_l2_o[2];
                        web_plru = '0;
                        if (|ufp_rmask) begin
                            ufp_rdata = data_out[hit_decision][offset_sel*32+:32];
                            ufp_resp = '1;
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
                    hit_on_way_1 : begin
                        state_next = idle;
                        hit_decision = 2'b01;
                        l0_l1_l2_in[0] = '0;
                        l0_l1_l2_in[1] = '1;
                        l0_l1_l2_in[2] = l0_l1_l2_o[2];
                        web_plru = '0;
                        if (|ufp_rmask) begin
                            ufp_rdata = data_out[hit_decision][offset_sel*32+:32];
                            ufp_resp = '1;
                            web_data[hit_decision] = '1;
                            dirty_in = '0;
                            web_dirty[hit_decision] = '1;
                        end else begin // (writing)
                            ufp_rdata = 'x;
                            ufp_resp = '1;
                            web_data[hit_decision] = '0;
                            dirty_in = '1;
                            web_dirty[hit_decision] = '0;
                        end
                    end
                    hit_on_way_2 : begin
                        state_next = idle;
                        hit_decision = 2'b10;
                        l0_l1_l2_in[0] = '1;
                        l0_l1_l2_in[1] = l0_l1_l2_o[1];
                        l0_l1_l2_in[2] = '0;
                        web_plru = '0;
                        if (|ufp_rmask) begin
                            ufp_rdata = data_out[hit_decision][offset_sel*32+:32];
                            ufp_resp = '1;
                            web_data[hit_decision] = '1;
                            dirty_in = '0;
                            web_dirty[hit_decision] = '1;
                        end else begin // (writing)
                            ufp_rdata = 'x;
                            ufp_resp = '1;
                            web_data[hit_decision] = '0;
                            dirty_in = '1;
                            web_dirty[hit_decision] = '0;
                        end
                    end
                    hit_on_way_3 : begin
                        state_next = idle;
                        hit_decision = 2'b11;
                        l0_l1_l2_in[0] = '1;
                        l0_l1_l2_in[1] = l0_l1_l2_o[1];
                        l0_l1_l2_in[2] = '1;
                        web_plru = '0;
                        if (|ufp_rmask) begin
                            ufp_rdata = data_out[hit_decision][offset_sel*32+:32];
                            ufp_resp = '1;
                            web_data[hit_decision] = '1;
                            dirty_in = '0;
                            web_dirty[hit_decision] = '1;
                        end else begin // (writing)
                            ufp_rdata = 'x;
                            ufp_resp = '1;
                            web_data[hit_decision] = '0;
                            dirty_in = '1;
                            web_dirty[hit_decision] = '0;
                        end
                    end
                    total_miss : begin
                        state_next = (dirty_o[plru_decision]) ? writeback : allocate;
                    end
                    default : begin //this should never happen
                        state_next = idle;
                    end
                endcase
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
                dfp_addr = {ufp_addr[31:5], 5'b00000};
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
