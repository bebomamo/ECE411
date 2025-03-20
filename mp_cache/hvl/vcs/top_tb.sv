module top_tb;
    timeunit 1ps;
    timeprecision 1ps;
    //---------------------------------------------------------------------------------
    // Waveform generation.
    //---------------------------------------------------------------------------------
    initial begin
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars(0, "+all");
    end
    //---------------------------------------------------------------------------------
    // Declare cache port signals
    //---------------------------------------------------------------------------------
    bit clk;
    bit rst;

    // CPU side signals (ufp -> upward facing port)
    logic [31:0] ufp_addr;
    logic [3:0] ufp_rmask;
    logic [3:0] ufp_wmask;
    logic [31:0] ufp_rdata;
    logic [31:0] ufp_wdata;
    logic ufp_resp;

    // Memory side signals (dfp -> downward facing port)
    logic [31:0] dfp_addr;
    logic dfp_read;
    logic dfp_write;
    logic [255:0] dfp_rdata;
    logic [255:0] dfp_wdata;
    logic dfp_resp;

    //---------------------------------------------------------------------------------
    // Instantiate the DUT
    //---------------------------------------------------------------------------------
    cache dut (
        .clk(clk),
        .rst(rst),
        .ufp_addr(ufp_addr),
        .ufp_rmask(ufp_rmask),
        .ufp_wmask(ufp_wmask),
        .ufp_rdata(ufp_rdata),
        .ufp_wdata(ufp_wdata),
        .ufp_resp(ufp_resp),
        .dfp_addr(dfp_addr),
        .dfp_read(dfp_read),
        .dfp_write(dfp_write),
        .dfp_rdata(dfp_rdata),
        .dfp_wdata(dfp_wdata),
        .dfp_resp(dfp_resp)
    );
    //---------------------------------------------------------------------------------
    // TODO: Generate a clock:
    //---------------------------------------------------------------------------------
    int clock_half_period_ps;
    initial begin
        $value$plusargs("CLOCK_PERIOD_PS_ECE411=%d", clock_half_period_ps);
        clock_half_period_ps = clock_half_period_ps / 2;
    end

    always #(clock_half_period_ps) clk = ~clk;

    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, dut, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, "+all");
        end
        rst = 1'b1;
        ufp_rmask <= '0;
        ufp_wmask <= '0;
        repeat (2) @(posedge clk);
        rst <= 1'b0;
    end

    // Memory Model
    logic [255:0] mem [logic [31:0]];

    // Function to generate a 256-bit cache line based on address
    function logic [255:0] generate_line(logic [31:0] addr);
        logic [255:0] line;
        for (int i = 0; i < 8; i++) begin
            line[i*32 +: 32] = addr + (i * 4);
        end
        return line;
    endfunction

    bit just_wrote;
    // Memory response logic
    always_ff @(posedge clk) begin
        if (dfp_read && !dfp_resp) begin
            if (mem.exists(dfp_addr)) begin
                dfp_rdata <= mem[dfp_addr];
            end else begin
                dfp_rdata <= generate_line(dfp_addr);
            end
            dfp_resp <= 1'b1;
            // just_wrote <= '0;
        end else if (dfp_write && !dfp_resp) begin
            mem[dfp_addr] <= dfp_wdata;
            dfp_resp <= 1'b1;
            // just_wrote <= '1;
        end else begin
            dfp_resp <= 1'b0;
            // just_wrote <= '0;
        end
    end
    
    // Read task
    task automatic read(input logic [31:0] addr, output logic [31:0] data);
        @(posedge clk);
        ufp_addr <= addr;
        ufp_rmask <= 4'b1111;  // Full word read
        ufp_wmask <= 4'b0000;
        // wait (ufp_resp == 1);
        wait (clk == '0 && ufp_resp == 1);
        // @(posedge clk);
        data = ufp_rdata;
        // ufp_rmask <= 4'b0000;  // Deassert
    endtask

    // Write task
    task automatic write(input logic [31:0] addr, input logic [31:0] wdata);
        @(posedge clk);
        ufp_addr <= addr;
        ufp_rmask <= 4'b0000;
        ufp_wmask <= 4'b1111;  // Full word write
        ufp_wdata <= wdata;
        // wait (ufp_resp == 1);
        wait (clk == '0 && ufp_resp == 1);
        // @(posedge clk);
        // ufp_wmask <= 4'b0000;  // Deassert
    endtask

    // Test suite
    initial begin
        logic [31:0] data;

        // Wait for reset to complete
        wait (rst == 0);
        #(clock_half_period_ps);  // Small delay after reset

        // Test 1: Basic Read (Cache Miss)
        $display("Test 1: Basic Read from 0x00000000");
        read(32'h00000000, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'h00000000) begin
            $error("Expected 0x00000000, got 0x%08x", data);
        end

        // Test 2: Read from Offset in Same Line
        $display("Test 2: Read from 0x00000004");
        read(32'h00000004, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'h00000004) begin
            $error("Expected 0x00000004, got 0x%08x", data);
        end

        // Test 3: Basic Write and Read Back
        $display("Test 3: Write 0xDEADBEEF to 0x00000000 and read it back");
        write(32'h00000000, 32'hDEADBEEF);
        // wait (ufp_resp == 0);
        read(32'h00000000, data);
        // wait (ufp_resp == 0);
        $display("Read data: 0x%08x", data);
        if (data != 32'hDEADBEEF) begin
            $error("Expected 0xDEADBEEF, got 0x%08x", data);
        end

        // Test 4a: Read to all ways in a set
        $display("Test 4a: Read from 0x00000204");
        read(32'h00000204, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'h00000204) begin
            $error("Expected 0x00000204, got 0x%08x", data);
        end

        // Test 4b: Read to all ways in a set
        $display("Test 4b: Read from 0x00000404");
        read(32'h00000404, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'h00000404) begin
            $error("Expected 0x00000404, got 0x%08x", data);
        end

        // Test 4c: Read to all ways in a set
        $display("Test 4c: Read from 0x00000804");
        read(32'h00000804, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'h00000804) begin
            $error("Expected 0x00000804, got 0x%08x", data);
        end

        // Test 5: Re-Read from one in the set to make sure plru updates properly
        $display("Test 5: Read from 0x00000404");
        read(32'h00000404, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'h00000404) begin
            $error("Expected 0x00000404, got 0x%08x", data);
        end

        // Test 6: Clean miss eviction
        $display("Test 6: Clean miss evict- Read from 0x00001404");
        read(32'h00001404, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'h00001404) begin
            $error("Expected 0x00001404, got 0x%08x", data);
        end

        // Test 7a: Dirty miss eviction
        $display("Test 7a: Write 0xBEB0B00B to 0x00000804 and read it back");
        write(32'h00000804, 32'hBEB0B00B);
        // wait (ufp_resp == 0);
        read(32'h00000804, data);
        // wait (ufp_resp == 0);
        $display("Read data: 0x%08x", data);
        if (data != 32'hBEB0B00B) begin
            $error("Expected 0xBEB0B00B, got 0x%08x", data);
        end

        // Test 7b: Dirty miss eviction
        $display("Test 7b: Dirty miss evict- Read from 0x00008404");
        read(32'h00008404, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'h00008404) begin
            $error("Expected 0x00008404, got 0x%08x", data);
        end

        // Test 8: Write to New Line and Read Back
        $display("Test 8: Write 0xBABECAFE to 0x00000020 and read it back");
        write(32'h00000020, 32'hCAFEBABE);
        // wait (ufp_resp == 0);
        read(32'h00000020, data);
        // wait (ufp_resp == 0);
        $display("Read data: 0x%08x", data);
        if (data != 32'hCAFEBABE) begin
            $error("Expected 0xCAFEBABE, got 0x%08x", data);
        end

        // Test 9: Verify Previous Write (Cache Persistence)
        $display("Test 9: Read back from 0x00000000");
        read(32'h00000000, data);
        $display("Read data: 0x%08x", data);
        if (data != 32'hDEADBEEF) begin
            $error("Expected 0xDEADBEEF, got 0x%08x", data);
        end

        // End simulation
        #(2 * clock_half_period_ps);  // Delay before finish
        $display("All tests completed.");
        $finish;
    end


endmodule : top_tb