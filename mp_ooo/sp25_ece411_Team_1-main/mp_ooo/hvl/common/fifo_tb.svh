logic enq_req, deq_req;
logic enq_ready, deq_ready;
logic [7:0] enq_data, deq_data;
int drain;
int dcount;

// 0 - default FIFO, 1 - free list fifo, for golden_queue to be accurate
int free_list = 1;

// DUT
fifo #(.WIDTH(8), .DEPTH(4), .CUSTOM(FREE_LIST)) dut (
    .clk(clk),
    .rst(rst),
    .enq_req(enq_req),
    .enq_data(enq_data),
    .enq_ready(enq_ready),
    .deq_req(deq_req),
    .deq_data(deq_data),
    .deq_ready(deq_ready)
);

// Golden Model
bit [7:0] golden_queue[$];
bit [7:0] expected_data;

// Clock generation
always #5 clk = ~clk;

initial begin
    $display("Starting FIFO test...");
    clk = 1'b0;
    rst = 1'b1;
    enq_req = 1'b0;
    deq_req = 1'b0;
    enq_data = 8'd0;

    if (free_list) begin
        for (int i = 0; i < 4; i++) begin
            golden_queue.push_back(i);
        end
    end
    
    // Reset
    #10 rst = 1'b0;

    // Enqueue 4 elements (Filling FIFO)
    for (int i = 0; i < 4; i++) begin
        @(posedge clk);
        if (enq_ready) begin
            enq_data = 8'(i + 1);
            enq_req = 1'b1;
            golden_queue.push_back(enq_data);
            $display("Enqueued: %0d", enq_data);
        end
    end
    @(posedge clk);
    enq_req = 1'b0;

    // Try enqueue when full (should not push)
    @(posedge clk);
    enq_data = 8'hFF;
    enq_req = enq_ready;
    @(posedge clk);
    $display("Tried enqueue when full: enq_ready = %0b", enq_ready);
    enq_req = 1'b0;

    // Dequeue all elements
    dcount = 0;
    @(posedge clk);
    while (dcount < 4) begin
        if (deq_ready) begin
            deq_req = 1'b1;
            @(posedge clk);
            expected_data = golden_queue.pop_front();
            if (deq_data !== expected_data) begin
                $display("ERROR: Mismatch! DUT = %0d, Golden = %0d", deq_data, expected_data);
            end else begin
                $display("PASS: DUT = %0d, Golden = %0d", deq_data, expected_data);
            end
            dcount++;
        end else begin
            deq_req = 1'b0;
            @(posedge clk);
        end
    end
    deq_req = 1'b0;

    // Try dequeue when empty (should not pop)
    @(posedge clk);
    deq_req = deq_ready;
    @(posedge clk);
    $display("Tried dequeue when empty: deq_ready = %0b", deq_ready);
    deq_req = 1'b0;

    // Fill again to test wraparound
    for (int i = 0; i < 3; i++) begin
        @(posedge clk);
        if (enq_ready) begin
            enq_data = 8'(i + 10);
            enq_req = 1'b1;
            golden_queue.push_back(enq_data);
            $display("Enqueued (wraparound test): %0d", enq_data);
        end else begin
            enq_req = 1'b0;
            i = i - 1;
        end
    end
    @(posedge clk);
    enq_req = 1'b0;

    // Simultaneous enqueue and dequeue
    @(posedge clk);
    if (enq_ready) begin
        enq_data = 8'hAA;
        enq_req = 1'b1;
        golden_queue.push_back(enq_data);
        $display("Enqueued: %0d", enq_data);
    end
    deq_req = deq_ready;
    @(posedge clk);
    if (deq_ready) begin
        expected_data = golden_queue.pop_front();
        if (deq_data !== expected_data)
            $display("ERROR: Mismatch during simultaneous op! DUT = %0d, Golden = %0d", deq_data, expected_data);
        else
            $display("PASS: Dequeued during simultaneous op: %0d", deq_data);
    end
    enq_req = 1'b0;
    deq_req = 1'b0;

    // Final drain
    drain = 0;
    @(posedge clk);
    $display("Dequeing list");
    while (drain < 3) begin
        if (deq_ready) begin
            deq_req = 1'b1;
            @(posedge clk);
            expected_data = golden_queue.pop_front();
            if (deq_data !== expected_data)
                $display("ERROR: Mismatch! DUT = %0d, Golden = %0d", deq_data, expected_data);
            else
                $display("PASS: DUT = %0d, Golden = %0d", deq_data, expected_data);
            drain++;
        end else begin
            deq_req = 1'b0;
            @(posedge clk);
        end
    end
    deq_req = 1'b0;

    $display("Finished FIFO test.");
    #10 $finish;
end

