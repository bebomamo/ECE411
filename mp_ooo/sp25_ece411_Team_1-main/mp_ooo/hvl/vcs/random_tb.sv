//-----------------------------------------------------------------------------
// Title                 : random_tb
// Project               : ECE 411 mp_verif
//-----------------------------------------------------------------------------
// File                  : random_tb.sv
// Author                : ECE 411 Course Staff
//-----------------------------------------------------------------------------
// IMPORTANT: If you don't change the random seed, every time you do a `make run`
// you will run the /same/ random test. SystemVerilog calls this "random stability",
// and it's to ensure you can reproduce errors as you try to fix the DUT. Make sure
// to change the random seed or run more instructions if you want more extensive
// coverage.
//------------------------------------------------------------------------------
module random_tb
import rv32i_types::*;
(
    mem_itf_banked.mem itf
);


    `include "randinst.svh"

    RandInst gen = new();

    assign itf.ready = 1'b1;

    // Do a bunch of LUIs to get useful register state.
    task init_register_state();
        localparam LINES = 4;  // Number of 256-bit lines to initialize
        logic [255:0] instr_line;
        instr_test_t instr;

        for (int i = 0; i < LINES; ++i) begin
            instr_line = '0;
            for (int j = 0; j < 4; ++j) begin
                if ((i * 4 + j) % 2 == 0) begin
                    gen.randomize() with {
                        instr.j_type.opcode == op_b_lui;
                        // instr.j_type.rd == (i * 4 + j) % 32;
                        instr.j_type.rd == 5'( (i * 4 + j) % 32 );
                    };
                end else begin
                    gen.randomize() with {
                        instr.i_type.opcode == op_b_imm;
                        instr.i_type.rs1    == 5'( (i * 4 + j) % 32 );
                        instr.i_type.funct3 == arith_f3_add;
                        instr.i_type.rd     == 5'( (i * 4 + j) % 32 );
                    };
                end
                instr_line[j*64 +: 32] = instr.word;  // Lower 32 bits padded into 64-bit beat
            end

            // // Now serve the 4-beat 256-bit line over 4 cycles
            // for (int beat = 0; beat < 4; ++beat) begin
            //     @(negedge itf.clk);
            //     itf.rdata <= instr_line[beat*64 +: 64];
            //     itf.rvalid <= 1'b1;
            //     itf.raddr <= i * 64;  // 64B-aligned address
            //     @(posedge itf.clk);
            // end
            itf.rvalid <= '0;
            itf.rdata  <= '0;
        end
    endtask : init_register_state
    // Note that this memory model is not consistent! It ignores
    // writes and always reads out a random, valid instruction.
    task run_random_instrs();
        instr_test_t instr;
        logic [255:0] instr_line;
        logic [63:0] burst_line [0:3];
        static int burst_count = 0;
        static int MAX_BURSTS = 64;

        while (burst_count < MAX_BURSTS) begin
                @(posedge itf.clk iff (itf.read && !itf.rst));

            repeat (2) @(posedge itf.clk);
            //itf.ready = '1;
            // Generate a 256-bit line = 4 random 32-bit instructions (each fits into 64-bit beat)
            instr_line = '0;
            for (int i = 0; i < 8; ++i) begin
                gen.randomize();
                instr = gen.instr;
                instr_line[i*32 +: 32] = instr.word; // insert 32-bit instruction into 64-bit slot
            end

            // Split into beats
            burst_line[0] = instr_line[63:0];
            burst_line[1] = instr_line[127:64];
            burst_line[2] = instr_line[191:128];
            burst_line[3] = instr_line[255:192];

            // Respond over 4 cycles
            for (int beat = 0; beat < 4; ++beat) begin
                itf.rdata  <= burst_line[beat];
                itf.raddr  <= itf.addr;
                itf.rvalid <= 1'b1;
                @(posedge itf.clk);
            end

            itf.rvalid <= '0;
            itf.rdata  <= '0;
            burst_count++;

        end
    endtask

    always @(posedge itf.clk iff !itf.rst) begin
        if ($isunknown(itf.read) || $isunknown(itf.write)) begin
            $error("Memory Error: read/write signal is 'x");
            itf.error <= 1'b1;
        end

        if (itf.read && itf.write) begin
            $error("Memory Error: Simultaneous memory read and write");
            itf.error <= 1'b1;
        end

        if (itf.read || itf.write) begin
            if ($isunknown(itf.addr)) begin
                $error("Memory Error: Address contains 'x");
                itf.error <= 1'b1;
            end

            // Check for 32-byte alignment for burst access (addr[5:0] should be zero)
            if (itf.addr[4:0] != 5'b0) begin
                $error("Memory Error: Address is not 32-byte aligned");
                itf.error <= 1'b1;
            end
        end
    end

    // A single initial block ensures random stability.
    initial begin

        // Wait for reset.
        @(posedge itf.clk iff itf.rst == 1'b0);

        // Get some useful state into the processor by loading in a bunch of state.
        init_register_state();

        // Run!
        run_random_instrs();

        // Finish up
        $display("Random testbench finished!");
        $finish;
    end

endmodule : random_tb
