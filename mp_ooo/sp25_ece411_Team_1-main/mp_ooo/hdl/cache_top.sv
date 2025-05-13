module cache_top 
#
(
    parameter WAY = 4,
    parameter SETS = 16
)
(

    input   logic               clk,
    input   logic               rst,

    // cpu side signals, ufp -> upward facing port
    input   logic   [31:0]      ufp_addr,
    input   logic   [3:0]       ufp_rmask,
    input   logic   [3:0]       ufp_wmask,
    output  logic   [255:0]     ufp_rdata,
    input   logic   [31:0]      ufp_wdata,
    output  logic               ufp_resp,

    // memory side signals, dfp -> downward facing port
    input   logic   [31:0]      dram_raddr,
    input   logic   [63:0]      dram_rdata,
    input   logic               dram_rvalid,
    output  logic   [31:0]      dram_addr,
    output  logic               dram_read,
    output  logic               dram_write,
    output  logic   [63:0]      dram_wdata,
    input   logic               dram_ready,

    input   logic               stop_req
);

    logic   [31:0]      dfp_addr;
    logic               dfp_read;
    logic               dfp_write;
    logic   [255:0]     dfp_rdata;
    logic   [255:0]     dfp_wdata;
    logic               dfp_resp;

    // UFP - CPU side signals, DFP - Memory side signals
    cache #(.WAY(WAY), .SETS(SETS)) cache_t(
        .clk(clk),
        .rst(rst),
        // UFP
        .ufp_addr(ufp_addr),
        .ufp_rmask(ufp_rmask),
        .ufp_wmask(ufp_wmask),
        .ufp_rdata(ufp_rdata),
        .ufp_wdata(ufp_wdata),
        .ufp_resp(ufp_resp),
        // DFP
        .dfp_addr(dfp_addr),
        .dfp_read(dfp_read),
        .dfp_write(dfp_write),
        .dfp_rdata(dfp_rdata),
        .dfp_wdata(dfp_wdata),
        .dfp_resp(dfp_resp),

        .stop_req(stop_req),
        .bmem_rvalid(dram_rvalid)
    );

    // Adapter placed between DFP of cache and DRAM to support burty accesses
    cache_adapter adapter_t (
        .clk(clk),
        .rst(rst),
        // Cache side signals
        .cache_addr(dfp_addr),
        .cache_wdata(dfp_wdata),
        .cache_read(dfp_read),
        .cache_write(dfp_write),
        .cache_resp(dfp_resp),
        .cache_rdata(dfp_rdata),
        // DRAM side signals
        .dram_raddr(dram_raddr),
        .dram_rdata(dram_rdata),
        .dram_rvalid(dram_rvalid),
        .dram_addr(dram_addr),
        .dram_read(dram_read),
        .dram_write(dram_write),
        .dram_wdata(dram_wdata),
        .dram_ready(dram_ready)
    );

endmodule
