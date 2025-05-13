module mem_arbiter (
    input  logic clk,
    input  logic rst,

    // IMEM cache port
    input  logic [31:0] bmem_addr_imem,
    input  logic        bmem_read_imem,
    input  logic        bmem_write_imem, // assumed always 0
    input  logic [63:0] bmem_wdata_imem,
    output logic        bmem_ready_imem,
    output logic [63:0] bmem_rdata_imem,
    output logic        bmem_rvalid_imem,
    output logic [31:0] bmem_raddr_imem,

    // DMEM cache port
    input  logic [31:0] bmem_addr_dmem,
    input  logic        bmem_read_dmem,
    input  logic        bmem_write_dmem,
    input  logic [63:0] bmem_wdata_dmem,
    output logic        bmem_ready_dmem,
    output logic [63:0] bmem_rdata_dmem,
    output logic        bmem_rvalid_dmem,
    output logic [31:0] bmem_raddr_dmem,

    // Shared memory interface
    output logic [31:0] bmem_addr,
    output logic        bmem_read,
    output logic        bmem_write,
    output logic [63:0] bmem_wdata,
    input  logic        bmem_ready,
    input  logic [31:0] bmem_raddr,
    input  logic [63:0] bmem_rdata,
    input  logic        bmem_rvalid
);

    logic [31:0] imem_tag, dmem_tag;
    logic imem_pending;
    logic [31:0] imem_pending_addr;

    // Cache-side ready signals
    assign bmem_ready_imem = bmem_ready;
    assign bmem_ready_dmem = bmem_ready;

    // Output address passthroughs
    assign bmem_raddr_imem = bmem_raddr;
    assign bmem_raddr_dmem = bmem_raddr;

    // Response routing based on raddr match
    assign bmem_rvalid_imem = (bmem_raddr == imem_tag) && bmem_rvalid;
    assign bmem_rdata_imem  = bmem_rdata;

    assign bmem_rvalid_dmem = (bmem_raddr == dmem_tag) && bmem_rvalid;
    assign bmem_rdata_dmem  = bmem_rdata;

    always_ff @(posedge clk) begin
        if (rst) begin
            imem_tag <= 32'd0;
            dmem_tag <= 32'd0;
            imem_pending <= '0;
            imem_pending_addr <= '0;
        end else begin
            // Tag incoming requests when issued
            if (bmem_ready) begin
                if (bmem_read_dmem || bmem_write_dmem) begin
                    dmem_tag <= bmem_addr_dmem;
                end else if (bmem_read_imem || imem_pending) begin
                    imem_tag <= bmem_addr_imem;
                end
                //imem pending for edge cases
                if((bmem_read_dmem && bmem_read_imem) || (bmem_read_imem && bmem_write_dmem)) begin
                    imem_pending <= '1;
                    imem_pending_addr <= bmem_addr_imem;
                end
                if (imem_pending && !bmem_write_dmem) begin
                    imem_pending <= '0;
                end
            end
        end
    end

    // Issue logic (prioritize DMEM)
    always_comb begin
        bmem_read  = '0;
        bmem_write = '0;
        bmem_addr  = 32'd0;
        bmem_wdata = 64'd0;

        if (bmem_ready) begin
            if ((bmem_read_dmem || bmem_write_dmem)) begin
                bmem_addr  = bmem_addr_dmem;
                bmem_read  = bmem_read_dmem;
                bmem_write = bmem_write_dmem;
                bmem_wdata = bmem_wdata_dmem;
            end 
            else if (imem_pending && !bmem_write_dmem) begin
                bmem_addr = imem_pending_addr;
                bmem_read = '1;
                bmem_wdata = bmem_wdata_imem;
                bmem_write = bmem_write_imem;
            end
            else if (bmem_read_imem) begin
                bmem_addr = bmem_addr_imem;
                bmem_read = '1;
                bmem_wdata = bmem_wdata_imem;
                bmem_write = bmem_write_imem;
            end
        end
    end

endmodule