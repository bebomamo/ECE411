// Parameters
parameter NUM_PORTS = 3;                       // Number of ports
parameter S_INDEX = 2;                         // Address width
parameter WIDTH = 8;                           // Data width
// Logic signals
logic [NUM_PORTS-1:0]                csb;           // Chip select array
logic [NUM_PORTS-1:0]                web;           // Write enable array
logic [S_INDEX-1:0]                  addr [3];      // Address array
logic [WIDTH-1:0]                    din  [3];      // Data input array
logic [WIDTH-1:0]                    dout [3];       // Data output array



param_ff_array #(.NUM_PORTS(NUM_PORTS), .S_INDEX(S_INDEX), .WIDTH(WIDTH)) dut
(
    .*
);

// Test Sequence
initial begin
    // Initialize
    clk = '0;
    rst = '1;
    csb = '1;   // All chip selects disabled
    web = '1;   // No writes
    @(posedge clk); 
    rst = '0; // Deassert reset
    @(posedge clk); 

    // Write to each port (uniques)
    $display("Writing to each port - Unique Test");
    for (int i = 0; i < NUM_PORTS; i++) begin
        csb[i] = '0;
        web[i] = '0;
        addr[i] = i[S_INDEX-1:0];
        din[i] = 8'b1 << i[S_INDEX-1:0];
    end
    
    @(posedge clk);     // Internal regs get value

    // Disable
    web = '1;           // Disable Write enable 

    @(posedge clk);     // Written on internal mem

    // Read from each port
    $display("Test Case 1: Read from each port - Unique Test");
    for (int i = 0; i < NUM_PORTS; i++) begin
        $display("addr: 0x%h, data: 0x%h", addr[i], dout[i]);
    end

    $display(" Test Case 2: Read from each port - One duplicate address Test");
    addr[0] = S_INDEX'('d1);
    addr[1] = S_INDEX'('d1);
    @(posedge clk);
    for (int i = 0; i < NUM_PORTS; i++) begin
        $display("addr: 0x%h, data: 0x%h", addr[i], dout[i]);
    end
    
    $display("Test Case 3: Read and Write at same address");
    web[0] = '0;        // Write enable port 0
    addr[0] = S_INDEX'('d1);
    addr[1] = S_INDEX'('d1);
    din[0] = 8'hAA;     // Write data
    @(posedge clk);
    web[0] = '1;        // Switch to read
    @(posedge clk);
    $display("addr: 0x%h, written on port0: 0xAA, read on port1: 0x%h", addr[1], dout[1]);

    $display("Test Case 4: Two ports writing to same address");
    web[0] = '0;        // Write enable port 0
    web[2] = '0;        // Write enable port 1
    addr[0] = S_INDEX'('d2);      // Same address for both ports
    addr[2] = S_INDEX'('d2);
    din[0] = 8'h55;     // Port 0 data
    din[2] = 8'hAA;     // Port 1 data
    @(posedge clk);
    web[0] = '1;
    web[2] = '1;
    @(posedge clk);
    $display("Should keep old value of 0x04 by design");
    $display("Port 0 - addr: 0x%h, written: 0x55, read: 0x%h", addr[0], dout[0]);
    $display("Port 1 - addr: 0x%h, written: 0xAA, read: 0x%h", addr[2], dout[2]);
    

    $finish;
end


