module cache_top_tb;
    //---------------------------------------------------------------------------------
    // Waveform generation.
    //---------------------------------------------------------------------------------
    initial begin
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars(0, "+all");
    end

    //---------------------------------------------------------------------------------
    // TODO: Declare cache port signals:
    //---------------------------------------------------------------------------------
    logic clk;
    logic rst;
    logic [31:0] ufp_addr;
    logic [3:0] ufp_rmask, ufp_wmask;
    logic [31:0] ufp_rdata, ufp_wdata;
    logic ufp_resp;
    logic [31:0] dfp_addr;
    logic dfp_read, dfp_write;
    logic [63:0] dfp_rdata, dfp_wdata;
    //logic [31:0] dram_rdata, dram_wdata;
    logic dfp_resp;
    logic dram_ready;
    logic [31:0] dram_resp_addr;

    //---------------------------------------------------------------------------------
    // TODO: Instantiate the DUT:
    //---------------------------------------------------------------------------------
    // cache dut (
    //     .clk(clk),
    //     .rst(rst),
    //     .ufp_addr(ufp_addr),
    //     .ufp_rmask(ufp_rmask),
    //     .ufp_wmask(ufp_wmask),
    //     .ufp_rdata(ufp_rdata),
    //     .ufp_wdata(ufp_wdata),
    //     .ufp_resp(ufp_resp),
    //     .dfp_addr(dfp_addr),
    //     .dfp_read(dfp_read),
    //     .dfp_write(dfp_write),
    //     .dfp_rdata(dfp_rdata),
    //     .dfp_wdata(dfp_wdata),
    //     .dfp_resp(dfp_resp)
    // );

    cache_top dut (
        .clk(clk),
        .rst(rst),
        .ufp_addr(ufp_addr),
        .ufp_rmask(ufp_rmask),
        .ufp_wmask(ufp_wmask),
        .ufp_rdata(ufp_rdata),
        .ufp_wdata(ufp_wdata),
        .ufp_resp(ufp_resp),

        .dram_resp_addr(dram_resp_addr),
        .dram_rdata(dfp_rdata),
        .dram_rvalid(dfp_resp),
        .dram_addr(dfp_addr),
        .dram_read(dfp_read),
        .dram_write(dfp_write),
        .dram_wdata(dfp_wdata),
        .dram_ready(dram_ready)
    );

    //---------------------------------------------------------------------------------
    // TODO: Generate a clock:
    //---------------------------------------------------------------------------------
    always #5 clk = ~clk;

    //---------------------------------------------------------------------------------
    // TODO: Verification constructs (recommended)
    //---------------------------------------------------------------------------------
    // Here's ASCII art of how the recommended testbench works:
    //                                +--------------+                           +-----------+
    //                       +------->| Golden model |---output_transaction_t--->|           |ufp_resp
    //                       |        +--------------+                           |           |
    //  input_transaction ---+                                                   | Check ==  |
    //                       |        +------+                                   |           |
    //                       +------->|  DUT |---output_transaction_t----------->|           |
    //                                +------+                                   +-----------+

    // Struct that defines an "input transaction" -- this is basically one
    // operation that's done on the cache.
    typedef struct packed {
        logic [31:0] address; // Address to read from.
        bit transaction_type; // Read or write? You could make an enum for this.
        // ... what else defines an input transaction? Think: rmask/wmask, data...
        logic [3:0] wmask;
        logic [3:0] rmask;
        logic [31:0] wdata;
        // Note that it's useful to include the DFP signals here as well for
        // planned misses, like this:
        bit [255:0] dfp_rdata;

        bit do_hit;
        // What else?
    } input_transaction_t;

    // The output transaction tells us how the cache is expected to behave due
    // to an input transaction.
    typedef struct packed {
        bit caused_writeback;
        bit caused_allocate;
        bit [31:0] returned_data;
        bit [255:0] dfp_writeback_data;
        // what else do you need?
        logic [31:0] dfp_writeback_address;
        logic [31:0] dfp_read_address;

        
    } output_transaction_t;

    logic [255:0] data_golden_arrays [15:0] [4];
    // Similarly, make arrays for tags, valid, dirty, plru.
    logic [22:0] tags_golden_arrays [15:0] [4];
    logic valid_golden_arrays [15:0] [4];
    logic dirty_golden_arrays [15:0] [4];
    logic [2:0] plru_golden [15:0];

    function input_transaction_t generate_input_transaction();
        // This function generates an input transaction. 

        input_transaction_t inp;
        bit do_hit;
        bit temp_tx;
        logic [3:0] temp_wmask;
        logic [3:0] temp_rmask;
        logic [31:0] temp_wdata;
        logic [31:0] temp_address; // Address to read from.
        bit temp_transaction_type; 
        bit [255:0] temp_dfp_rdata;

        // Pick whether to generate a hit or miss.
        bit has_valid_entry;
        has_valid_entry = 1'b0;
        for (int s = 0; s < 16; s++) begin
            for (int w = 0; w < 4; w++) begin
                if (valid_golden_arrays[s][w]) begin
                    has_valid_entry = 1'b1;
                    break;
                end
            end
        end
        // Randomly decide if this transaction should be a hit or a miss
        std::randomize(do_hit);

        if (!has_valid_entry) do_hit = 1'b0;

        inp.do_hit = do_hit;

        if (do_hit) begin
            // If we're generating a hit, we need to request an address that's
            // actually in the cache. Call:

            // get_cached_addresses(); Write this function to query golden tag
            // arrays, then fill out inp.address and other inp fields.
            inp.address = get_cached_address();

        // Randomly set read or write transaction type
            std::randomize(temp_tx);
            //inp.transaction_type = 1'b0;
            inp.transaction_type = temp_tx;
            
            if (inp.transaction_type) begin // Write operation
                std::randomize(temp_wmask);   // Random write mask
                if (temp_wmask == 4'b0000)
                    temp_wmask = 4'b1111;
                inp.wmask = temp_wmask;
                std::randomize(temp_wdata);   // Random write data
                inp.wdata = temp_wdata;
                inp.rmask = 4'b0000;         // No read
            end else begin // Read operation
                std::randomize(temp_rmask);   // Random read mask
                if (temp_rmask == 4'b0000)
                    temp_rmask = 4'b1111;
                inp.rmask = temp_rmask;
                inp.wmask = 4'b0000;         // No write
                inp.wdata = 32'b0;
            end
        end else begin // do miss
            // do:
            // std::randomize(inp) with {...};
            // Since it's a miss, we must fill out inp.dfp_* signals.
            // inp.address can be completely random.
            bit tag_conflict;
            logic [3:0] set_index;
            logic [22:0] new_tag;
            integer s;

            do begin
                // Randomly generate an address
                std::randomize(temp_address);
                $display(" Temp Address: 0x%h", temp_address);
                inp.address = {temp_address[31:2], 2'b0};
                set_index = inp.address[8:5];

                std::randomize(new_tag);
                $display(" new_tag: 0x%h", new_tag);
                inp.address[31:9] = new_tag;

                $display("  Address: 0x%h", inp.address);

                // Check if this tag exists in any valid way for this set
                tag_conflict = 1'b0;
                for (s=0; s<16; s++)begin
                    for (int w = 0; w < 4; w++) begin
                        if (valid_golden_arrays[s][w] && tags_golden_arrays[s][w] == new_tag) begin
                            tag_conflict = 1'b1; // Conflict detected
                            break;
                        end
                    end
                end
            end while (tag_conflict); // Keep regenerating if the tag exists

            // Randomly set transaction type (read or write)
            std::randomize(temp_transaction_type);
            inp.transaction_type = temp_transaction_type;
            if (inp.transaction_type) begin // Write operation
                std::randomize(temp_wmask);
                if (temp_wmask == 4'b0000)
                    temp_wmask = 4'b1111;
                inp.wmask = temp_wmask;
                std::randomize(temp_wdata);
                inp.wdata = temp_wdata;
                inp.rmask = 4'b0000;
            end else begin // Read operation
                std::randomize(temp_rmask);
                if (temp_rmask == 4'b0000)
                    temp_rmask = 4'b1111;
                inp.rmask = temp_rmask;
                inp.wmask = 4'b0000;
                inp.wdata = 32'b0;
            end

            // Since it's a miss, generate random memory response (dfp_rdata)
            $display("  Address: 0x%h", inp.address);
            std::randomize(temp_dfp_rdata);
            inp.dfp_rdata = temp_dfp_rdata;
        end

        return inp;
    endfunction : generate_input_transaction

    function logic [31:0] get_cached_address(); 
        logic [3:0] set_index;
        logic [22:0] tag;
        logic [31:0] address;
        integer i;
        integer s;
        int way;
        bit found_valid;
        logic [4:0] block_offset;
        found_valid = 1'b0;
        



        for (s=0; s<16; s++) begin
            for (i=0; i<4; i++) begin
                if(valid_golden_arrays[s][i]) begin
                    way = i;
                    tag = tags_golden_arrays[s][i];
                    set_index = s[3:0];
                    found_valid = 1'b1;
                end
            end
        end
        if(!found_valid) begin
            $display("couldnt find valid");
            std::randomize(address);
        end
        else begin
            std::randomize(block_offset);
        end
        address = {tag, set_index, block_offset[4:2], 2'b0};

        return address;
    endfunction: get_cached_address

    function output_transaction_t golden_cache_do(input_transaction_t inp);
        output_transaction_t out;
        // Do operations on the arrays, and fill up "out" correctly. Use "="
        // assignment here: this is not RTL. It is a behavioral software model 
        // of the cache.
        logic [3:0] set_index;
        logic [22:0] tag;
        logic hit;
        int way; // Way in the set
        int evict_way; // Way to evict if needed
        bit dirty_evict;
        logic  [2:0] word_offset;
        
        // Extract set index and tag from the input address
        set_index = inp.address[8:5]; // Adjust based on your index bits
        tag = inp.address[31:9];
        word_offset = inp.address[4:2];

        // Initialize output transaction defaults
        out.caused_writeback = 1'b0;
        out.caused_allocate = 1'b0;
        out.returned_data = 32'h0;
        out.dfp_writeback_data = 256'd0;
        out.dfp_writeback_address = 32'h0;
        out.dfp_read_address = 32'h0;
        
        hit = 1'b0;
        way = -1;
        
        // Check for a hit in the cache
        for (int w = 0; w < 4; w++) begin
            if (valid_golden_arrays[set_index][w] && tags_golden_arrays[set_index][w] == tag) begin
                hit = 1'b1;
                way = w;
                break;
            end
        end

        if (hit) begin
            // **Cache Hit Handling**
            if (inp.transaction_type) begin // **Write operation**
                // Update cache data
                // for (int i = 0; i < 4; i++) begin
                //     if (inp.wmask[i]) begin
                //         data_golden_arrays[set_index][way][(i * 8) +: 8] = inp.wdata[(i * 8) +: 8];
                //     end
                // end
                $display("BEFORE data_golden_arrays[s][w]: %h", data_golden_arrays[set_index][way]);
                data_golden_arrays[set_index][way][(word_offset*32) +: 32] = (data_golden_arrays[set_index][way][(word_offset*32) +: 32] & ~{{8{inp.wmask[3]}},{8{inp.wmask[2]}},{8{inp.wmask[1]}},{8{inp.wmask[0]}}}) |  (inp.wdata & {{8{inp.wmask[3]}},{8{inp.wmask[2]}},{8{inp.wmask[1]}},{8{inp.wmask[0]}}});
                $display("AFTRE data_golden_arrays[s][w]: %h", data_golden_arrays[set_index][way]);
                dirty_golden_arrays[set_index][way] = 1'b1; // Mark as dirty
            end else begin // **Read operation**
                // Read the correct word from the cache line
                out.returned_data = data_golden_arrays[set_index][way][(word_offset * 32) +: 32];
                $display("  word_offset: %b", word_offset);
            end

             update_plru(set_index, way);

        end else begin
            // **Cache Miss Handling**
            out.caused_allocate = 1'b1;

            // Find a way to evict using PLRU (or pick the first invalid)
            // evict_way = -1;
            // for (int w = 0; w < 4; w++) begin
            //     if (!valid_golden_arrays[set_index][w]) begin
            //         evict_way = w; // Use an empty slot
            //         break;
            //     end
            // end
            
            // If no invalid lines, evict using PLRU
            //if (evict_way == -1) begin
            $display("lru_golden[set_index]: %b", plru_golden[set_index]);
                evict_way = decode_plru(plru_golden[set_index]);; // PLRU way to evict
           // end
            $display("evict way: %d", evict_way);
            $display("set_index: %d", set_index);
            // Check if eviction is dirty (writeback needed)
            dirty_evict = dirty_golden_arrays[set_index][evict_way];
            
            $display("dirty evic?: %d", dirty_evict);
            if (dirty_evict) begin
                out.caused_writeback = 1'b1;
                out.caused_allocate = 1'b1;
                out.dfp_writeback_data = data_golden_arrays[set_index][evict_way];
                out.dfp_writeback_address = {tags_golden_arrays[set_index][evict_way], set_index, 5'b0}; // Old block address
            end
            
            out.dfp_read_address = {inp.address[31:5], 5'b0}; 
            // Load new block from memory
            tags_golden_arrays[set_index][evict_way] = tag;
            valid_golden_arrays[set_index][evict_way] = 1'b1;
            dirty_golden_arrays[set_index][evict_way] = 1'b0;
            data_golden_arrays[set_index][evict_way] = inp.dfp_rdata; // Load data from memory
            
            // If it was a read request, return the first word of the fetched block
            if (!inp.transaction_type) begin
                out.returned_data = inp.dfp_rdata[(word_offset * 32) +: 32];
            end

            update_plru(set_index, evict_way);
        end

        return out;
    endfunction : golden_cache_do

    function int decode_plru(input logic [2:0] plru_bits);
        int evict_way;
            unique casez (plru_bits)
                3'b00?: evict_way = 0;
                3'b01?: evict_way = 1;
                3'b1?0: evict_way = 2;
                3'b1?1: evict_way = 3;
                default: evict_way =0;
            endcase
        return evict_way;
    endfunction : decode_plru

    function void update_plru(input logic [3:0] set_index, input int accessed_way);
        case (accessed_way)
            0: plru_golden[set_index] = {1'b1, 1'b1, plru_golden[set_index][0]}; // Used way 0
            1: plru_golden[set_index] = {1'b1, 1'b0, plru_golden[set_index][0]}; // Used way 1
            2: plru_golden[set_index] = {1'b0, plru_golden[set_index][1], 1'b1}; // Used way 2
            3: plru_golden[set_index] = {1'b0, plru_golden[set_index][1], 1'b0}; // Used way 3
        endcase
    endfunction : update_plru


task drive_dut(input input_transaction_t inp, output output_transaction_t out);
    // Step 1: Drive **only DUT inputs**
    @(posedge clk);
    ufp_addr  <= inp.address;
    ufp_rmask <= inp.rmask;
    ufp_wmask <= inp.wmask;
    ufp_wdata <= inp.wdata;

    dfp_resp  <= 1'b0;    // Default to no memory response
    dfp_rdata <= 64'b0;  // Default to no read data

    // Step 2: Wait for DUT to request memory access (`dfp_read` or `dfp_write`)
    $display("hit?: %0d", inp.do_hit);
    if(!inp.do_hit)
        wait (dfp_read || dfp_write);
    out.caused_writeback   = dfp_write;
    @(posedge clk);
    if (dfp_read) begin
        dfp_resp  <= 1'b1;  // Provide memory response
        dfp_rdata <= inp.dfp_rdata[63:0];  // Send memory read data
        @(posedge clk)
        dfp_rdata <= inp.dfp_rdata[127:64];
        dfp_resp  <= 1'b1;
        @(posedge clk)
        dfp_rdata <= inp.dfp_rdata[191:128];
        dfp_resp  <= 1'b1;
        @(posedge clk)
        dfp_rdata <= inp.dfp_rdata[255:192];
        dfp_resp  <= 1'b1;
        @(posedge clk);
        dfp_resp  <= 1'b0;
        dfp_rdata <= 64'd0;
    end 
    else if (dfp_write) begin
        //dfp_resp  <= 1'b1;  // Indicate memory received the write request
        //out.caused_writeback   = dfp_write; 
        @(posedge clk)
        out.dfp_writeback_data[63:0] = dfp_wdata;
        @(posedge clk)
        out.dfp_writeback_data[127:64] = dfp_wdata;
        @(posedge clk)
        out.dfp_writeback_data[191:128] = dfp_wdata;
        @(posedge clk)
        out.dfp_writeback_data[255:192] = dfp_wdata;
        out.dfp_writeback_address = dfp_addr;
        wait (dfp_read);
        @(posedge clk)
         if (dfp_read) begin
            dram_resp_addr = dfp_addr;
            dfp_resp  <= 1'b1;  // Provide memory response
            dfp_rdata <= inp.dfp_rdata[63:0];  // Send memory read data
            @(posedge clk)
            dfp_rdata <= inp.dfp_rdata[127:64];
            dfp_resp  <= 1'b1;
            @(posedge clk)
            dfp_rdata <= inp.dfp_rdata[191:128];
            dfp_resp  <= 1'b1;
            @(posedge clk)
            dfp_rdata <= inp.dfp_rdata[255:192];
            dfp_resp  <= 1'b1;
            @(posedge clk);
            dfp_resp  <= 1'b0;
            dfp_rdata <= 64'd0;
            dram_resp_addr = 32'd0;
        end 
    end
    else begin
        out.dfp_writeback_data = 256'd0;
    end
    out.dfp_read_address        = dfp_addr; 
    //out.caused_writeback   = dfp_write;
    // Step 3: Read **DUT memory-side outputs** (DO NOT assign them)
    @(posedge clk);
            // Read memory-side address
            // Read writeback data
    //out.caused_writeback   = dfp_write;        // Read write signal
    out.caused_allocate    = dfp_read;         // Read read signal

    // Step 4: Wait for DUT to signal CPU response (`ufp_resp`)
    wait (ufp_resp === 1'b1);

    // Step 5: Read **DUT CPU-side outputs** (DO NOT assign them)
    //@(posedge clk);
    out.returned_data = ufp_rdata;  // Read CPU-side response data

    // Step 6: Reset only **testbench-driven inputs**
    //@(posedge clk);
    ufp_addr  <= 32'b0;
    ufp_rmask <= 4'b0;
    ufp_wmask <= 4'b0;
    ufp_wdata <= 32'b0;
    
    dfp_resp  <= 1'b0;  // Reset memory response
    dfp_rdata <= 64'b0; // Reset memory read data
endtask : drive_dut


    function compare_outputs(output_transaction_t golden_out, output_transaction_t dut_out);
        // Compare the output structs, and $error() if there's a mismatch.
        if (golden_out.returned_data !== dut_out.returned_data) begin
            $error("Mismatch in returned data! Expected: %h, Got: %h", 
                    golden_out.returned_data, dut_out.returned_data);
            $fatal("fatal");
        end

        // Compare writeback flag
        if (golden_out.caused_writeback !== dut_out.caused_writeback) begin
            $error("Mismatch in writeback flag! Expected: %b, Got: %b", 
                    golden_out.caused_writeback, dut_out.caused_writeback);
            $fatal("fatal");
        end

        // Compare allocated flag
        if (golden_out.caused_allocate !== dut_out.caused_allocate) begin
            $error("Mismatch in allocation flag! Expected: %b, Got: %b", 
                    golden_out.caused_allocate, dut_out.caused_allocate);
            $fatal("fatal");
        end

        // Compare writeback data
        if (golden_out.dfp_writeback_data !== dut_out.dfp_writeback_data) begin
            $error("Mismatch in writeback data! Expected: %h, Got: %h", 
                    golden_out.dfp_writeback_data, dut_out.dfp_writeback_data);
            $fatal();
        end

        // Compare writeback address
        if (golden_out.dfp_writeback_address !== dut_out.dfp_writeback_address && golden_out.caused_writeback) begin
            $error("Mismatch in writeback address! Expected: %h, Got: %h", 
                    golden_out.dfp_writeback_address, dut_out.dfp_writeback_address);

            $fatal();
        end

        if (golden_out.dfp_read_address !== dut_out.dfp_read_address && golden_out.caused_allocate) begin
            $error("Mismatch in dfp read address! Expected: %h, Got: %h", 
                    golden_out.dfp_read_address, dut_out.dfp_read_address);

            $fatal();
        end
        
    endfunction : compare_outputs

    //---------------------------------------------------------------------------------
    // TODO: Main initial block that calls your tasks, then calls $finish
    //---------------------------------------------------------------------------------
   
   
   
    initial begin
        // Step 1: Reset the system
        integer z;
        for (z=0; z<16; z++)begin
            plru_golden[z] = 3'b000;
        end
        clk = 1'b0;
        rst = 1'b1;
        ufp_addr = 32'b0;
        ufp_rmask = 4'b0;
        ufp_wmask = 4'b0;
        ufp_wdata = 32'b0;
        dfp_rdata = 64'd0;
        dfp_resp = 1'b0;
        #20 rst = 1'b0; // Deassert reset after 20 time units

        // Step 2: Run multiple test iterations
        for (int i = 0; i < 100; i++) begin // Run 100 randomized test cases
            input_transaction_t inp;
            output_transaction_t golden_out, dut_out;

            // Generate a random input transaction
            inp = generate_input_transaction();

            $display("Generated Input Transaction at time %0t:", $time);
            $display("  Address: 0x%h", inp.address);
            $display("  Type: %s", (inp.transaction_type ? "WRITE" : "READ"));
            $display("  Wmask: %b", inp.wmask);
            $display("  Rmask: %b", inp.rmask);
            $display("  Wdata: 0x%h", inp.wdata);
            $display("  DFP_Rdata: 0x%h", inp.dfp_rdata);            
            // Compute the expected golden model output
            golden_out = golden_cache_do(inp);
            $display("golden out");
            // Drive the DUT and capture its output
            drive_dut(inp, dut_out);
            $display("drive dut out");

            // Compare the DUT output with the expected output
            compare_outputs(golden_out, dut_out);

            // Step 3: Introduce delay to allow cache response
            repeat (5) @(posedge clk); // Wait 5 clock cycles before the next transaction

            $display("Cycle: %0d", i);
        end

        // Step 4: End simulation
        $display("Simulation completed.");
        $finish;
    end

   
   
    // initial begin
    //     // Reset the system
    //     clk = 1'b0;
    //     rst = 1'b1;
    //     ufp_addr = 32'b0;
    //     ufp_rmask = 4'b0;
    //     ufp_wmask = 4'b0;
    //     ufp_wdata = 32'b0;
    //     dfp_rdata = 256'h0;
    //     dfp_resp = 1'b0;
        
    //     #10 rst = 1'b0; // Deassert reset after 10 time units

    //     // Test Case 1: Read miss (should trigger allocation)
    //     #10;
    //     ufp_addr = 32'h0000_1000;  // Some address not in cache
    //     ufp_rmask = 4'b1111;       // Read full word
    //     ufp_wmask = 4'b0000;       // No write
    //     ufp_wdata = 32'h0;         // No write data
    //     #20
    //     // repeat (20) @(posedge clk);

    //     // @(posedge clk iff dfp_resp);
    //     // @(posedge dfp_resp);

    //     dfp_rdata = 256'd4369;
    //     dfp_resp = 1'b1;


    //     #10
    //     dfp_resp = 1'b0;
    //     dfp_rdata = 256'd0;

    //     @(posedge ufp_resp);
    //     #15
    //     ufp_addr = 32'h0000_2000;  // Another address not in cache
    //     ufp_rmask = 4'b0000;
    //     ufp_wmask = 4'b1111;       // Writing full word
    //     ufp_wdata = 32'hDEADBEEF;  // Sample data to write

    //     #20
    //     dfp_rdata = 256'd4369;
    //     dfp_resp = 1'b1;
    //     #10
    //     dfp_resp = 1'b0;
    //     dfp_rdata = 256'd0;

    //      @(posedge ufp_resp);
    //     #15;  // Wait to observe response

    //     // Test Case 3: Read hit (expect response without memory access)
    //     #10;
    //     ufp_addr = 32'h0000_1000;  // Address that should now be cached
    //     ufp_rmask = 4'b1111;
    //     ufp_wmask = 4'b0000;
    //     ufp_wdata = 32'h0;
    //     @(posedge ufp_resp);
    //     #20;

    //     // Test Case 4: Write hit (modify cache without memory access)
    //     #10;
    //     ufp_addr = 32'h0000_1000;  // Writing to an address in cache
    //     ufp_rmask = 4'b0000;
    //     ufp_wmask = 4'b1111;
    //     ufp_wdata = 32'hCAFEBABE;  // New data to write
    //      @(posedge ufp_resp);
    //     #20;

    //     // End simulation
    //     $finish;
    // end
endmodule : cache_top_tb