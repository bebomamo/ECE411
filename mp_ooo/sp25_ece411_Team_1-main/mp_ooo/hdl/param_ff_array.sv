module param_ff_array #(
    parameter NUM_PORTS = 2,        // Number of ports, parametrizable
    parameter S_INDEX   = 4,        // Address index size
    parameter WIDTH     = 1,         // Data width
    parameter REGISTER_INPUTS = 1,   // 0 - same cycle read, next cycle write, 1 - next cycle read w/ PF, 2 cycle write 
    parameter PORT_FORWARD = 1      // 0 - off, 1 - on
)(
    input  logic                  clk,          // Single clock for all ports
    input  logic                  rst,          // Single reset for all ports
    input  logic [NUM_PORTS-1:0]  csb,          // Chip select array
    input  logic [NUM_PORTS-1:0]  web,          // Write enable array
    input  logic [S_INDEX-1:0]    addr [NUM_PORTS], // Address array
    input  logic [WIDTH-1:0]      din  [NUM_PORTS], // Data input array
    output logic [WIDTH-1:0]      dout [NUM_PORTS]  // Data output array
);

    localparam NUM_SETS = 2**S_INDEX; // Number of memory locations

    // Registered signals for each port
    logic [NUM_PORTS-1:0]      web_reg;    // Write enable registers
    logic [S_INDEX-1:0]        addr_reg [NUM_PORTS]; // Address registers
    logic [WIDTH-1:0]          din_reg  [NUM_PORTS]; // Data input registers

    // Internal flip-flop array
    logic [WIDTH-1:0]          internal_array [NUM_SETS];

    logic port_conflict;

    // Register input signals on clock edge
    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < NUM_PORTS; i++) begin
                web_reg[i]  <= 1'b1;    // Disable writes on reset
                addr_reg[i] <= 'x;      // Unknown address
                din_reg[i]  <= 'x;      // Unknown data
            end
        end else begin
            for (integer i = 0; i < NUM_PORTS; i++) begin
                if (!csb[i]) begin      // Chip select active low
                    web_reg[i]  <= web[i];
                    addr_reg[i] <= addr[i];
                    din_reg[i]  <= din[i];
                end
            end
        end
    end

    // Update internal array on clock edge
    // always_ff @(posedge clk) begin
    //     if (rst) begin
    //         for (integer i = 0; i < NUM_SETS; i++) begin
    //             internal_array[i] <= '0; // Reset array to 0
    //         end
    //     end else begin
    //         if (!REGISTER_INPUTS) begin
    //             for (integer i = 0; i < NUM_PORTS; i++) begin
    //                 if (!web[i]) begin
    //                     internal_array[addr[i]] <= din[i];
    //                 end
    //             end    
    //         end
    //         else begin 
    //             for (integer i = 0; i < NUM_PORTS; i++) begin
    //                 if (!web_reg[i]) begin
    //                     internal_array[addr_reg[i]] <= din_reg[i];
    //                 end
    //             end 
    //         end
    //     end
    // end
    generate
        if (REGISTER_INPUTS == 0) begin : gen_no_reg_input
            always_ff @(posedge clk) begin
                if (rst) begin
                    for (integer i = 0; i < NUM_SETS; i++) begin
                        internal_array[i] <= '0;
                    end
                end else begin
                    for (integer i = 0; i < NUM_PORTS; i++) begin
                        if (!web[i]) begin
                            internal_array[addr[i]] <= din[i];
                        end
                    end
                end
            end
        end else begin : gen_reg_input
            always_ff @(posedge clk) begin
                if (rst) begin
                    for (integer i = 0; i < NUM_SETS; i++) begin
                        internal_array[i] <= '0;
                    end
                end else begin
                    for (integer i = 0; i < NUM_PORTS; i++) begin
                        if (!web_reg[i]) begin
                            internal_array[addr_reg[i]] <= din_reg[i];
                        end
                    end
                end
            end
        end
    endgenerate

    // Combinational read logic
    always_comb begin
        if (!REGISTER_INPUTS) begin
            for (integer i = 0; i < NUM_PORTS; i++) begin
                dout[i] = internal_array[addr[i]]; // Default read
            end
        end
        else if (!PORT_FORWARD) begin
            for (integer i = 0; i < NUM_PORTS; i++) begin
                dout[i] = internal_array[addr_reg[i]]; // Default read
            end
        end
        else begin
            for (integer i = 0; i < NUM_PORTS; i++) begin
                dout[i] = internal_array[addr_reg[i]]; // Default read

                // Check other ports for write-to-same-address
                for (integer j = 0; j < NUM_PORTS; j++) begin
                    if (i != j && !web_reg[j] && !csb[j] && addr_reg[i] == addr_reg[j]) begin
                        dout[i] = din_reg[j]; // Forward write data
                    end
                end
            end
        end
    end

    //TODO: Make port conflict logic if we run into a write to the same address case

endmodule : param_ff_array
