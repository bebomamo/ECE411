module cache_adapter (
    // Cache Interface
    input   logic               clk,
    input   logic               rst,
    input   logic   [31:0]      cache_addr,
    input   logic   [255:0]     cache_wdata,
    input   logic               cache_read,
    input   logic               cache_write,
    output  logic               cache_resp,
    output  logic   [255:0]     cache_rdata,

    // Memory Interface
    input   logic  [31:0]       dram_raddr,
    input   logic   [63:0]      dram_rdata,
    input   logic               dram_rvalid,
    output  logic   [31:0]      dram_addr,
    output  logic               dram_read,
    output  logic               dram_write,
    output  logic   [63:0]      dram_wdata,
    input   logic               dram_ready
);

    // Logic Signals
    logic [63:0] read_buffer [3:0];
    logic [63:0] write_buffer [3:0];
    logic [1:0] count;
    logic line_ready;
    logic cache_write_reg;

    // TODO Remove dummy variable and find case for when raddr and order of read requests differ
    logic dummy_var;
    assign dummy_var = (|dram_raddr) ? '1 : '0;

    assign dram_addr = cache_addr;                      // Should already 256 aligned
    assign dram_write = (cache_write) ? cache_write_reg : '0;                  // From WRITEBACK stage of cache, write high for 4 cycle

    assign write_buffer[0] = cache_wdata[63:0];
    assign write_buffer[1] = cache_wdata[127:64];
    assign write_buffer[2] = cache_wdata[191:128];
    assign write_buffer[3] = cache_wdata[255:192];


    logic cache_read_d;
    logic stop_req_reg;

    always_ff @(posedge clk) begin
        if (rst) begin
            cache_read_d <= 1'b0;
            dram_read <= 1'b0;
            cache_write_reg <= '0;
            stop_req_reg <= '0;
        end else begin
            // TODO Ensure read stays high for consecutive read requests, (can maybe ignore for our design)
            cache_read_d <= cache_read;
            dram_read <= cache_read && !cache_read_d;  // one-cycle read pulse
            cache_write_reg <= cache_write;
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            count <= 2'b00;
            cache_resp <= 1'b0;
        end
        else begin
            
            // READ CASE
            if(cache_read & dram_ready) begin
                // TODO line_ready may be redundant, chech that dram_rvalid holds 4 cycles
                if (line_ready) begin
                    count <= 2'b00;
                    cache_rdata <= 256'd0;
                    cache_resp <= 1'b0;
                    line_ready <= 1'b0;
                end
                else if(dram_rvalid) begin
                    read_buffer[count] <= dram_rdata;
                    count <= count + 2'd1;
                    // Line ready
                    if(count == 2'b11) begin
                        cache_rdata <= {dram_rdata, read_buffer[2], read_buffer[1], read_buffer[0]};
                        cache_resp <= 1'b1;     // Tell cache rdata is valid
                        line_ready <= 1'b1;
                    end
                end
                else begin
                    count <= '0;
                    line_ready <= 1'b0;
                end
            end

            // WRITE CASE
            else if (cache_write & dram_ready) begin
                // Complete write transaction
                if (line_ready) begin
                    count <= 2'b00;
                    dram_wdata <= 64'd0;
                    cache_resp <= 1'b0;
                    line_ready <= 1'b0;
                end
                // Write double word per cycle
                else begin
                    dram_wdata <= write_buffer[count];
                    count <= count + 2'd1;
                    if(count == 2'b11) begin
                        cache_resp <= 1'b1;     // Tell cache data is written
                        line_ready <= 1'b1;
                    end
                end
            end

            // DEFAULT/IDLE CASE
            else begin
                line_ready <= 1'b0;
                cache_resp <= 1'b0;
            end
        end
    end

endmodule
