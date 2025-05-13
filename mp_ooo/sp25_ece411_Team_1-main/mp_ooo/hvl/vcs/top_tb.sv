// Uncomment define line for desired test
`define CPU_TEST
//`define PARAM_FF_TEST
//`define RAT_ARF_TEST
//`define FIFO_TEST
module top_tb;

    timeunit 1ps;
    timeprecision 1ps;
    import rv32i_types::*;

    int clock_half_period_ps;
    initial begin
        $value$plusargs("CLOCK_PERIOD_PS_ECE411=%d", clock_half_period_ps);
        clock_half_period_ps = clock_half_period_ps / 2;
    end

    bit clk;
    always #(clock_half_period_ps) clk = ~clk;
    bit rst;

    initial begin
        $fsdbDumpfile("dump.fsdb");
        if ($test$plusargs("NO_DUMP_ALL_ECE411")) begin
            $fsdbDumpvars(0, dut, "+all");
            $fsdbDumpoff();
        end else begin
            $fsdbDumpvars(0, "+all");
        end
        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst <= 1'b0;
    end

    `ifdef CPU_TEST
    `include "top_tb.svh"
    `endif // CPU_TEST

    // `ifdef PARAM_FF_TEST
    // `include "param_ff_top.svh"
    // `endif // PARAM_FF_TEST

    // `ifdef RAT_ARF_TEST
    // `include "rat_arf_tb.svh"
    // `endif // RAT_ARF_TEST

    // `ifdef FIFO_TEST
    // `include "fifo_tb.svh"
    // `endif // FIFO_TEST



endmodule
