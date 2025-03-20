module lfsr #(
    parameter logic [15:0]  SEED_VALUE = 'hECEB
) (
    input   logic           clk,
    input   logic           rst,
    input   logic           en,
    output  logic           rand_bit,
    output  logic   [15:0]  shift_reg
);

	// TODO: Fill this out!

	//  Example test-bench workthough
	// 	1110 1100 1110 1011 : eceb
	// 	____ ____ __^_ ^^_^
	// 	1111 0110 0111 0101 : >1 : f675
	// 	____ ____ __^_ ^^_^
	// 	1111 1011 0011 1010 : >1 : fb3a
	// 	____ ____ __^_ ^^_^
	// 	0111 1101 1001 1101 : >0 : 7d9ds
	

	// Create combinational logic shift_in
	logic shift_in;
	assign shift_in = shift_reg[0] ^ shift_reg[2] ^ shift_reg[3] ^ shift_reg[5];

	logic [14:0] r_s;
	assign r_s = shift_reg[15:1];

	always_ff @(posedge clk) begin
		if(~rst) begin
			if(en) begin
				rand_bit <= shift_reg[0];
				shift_reg[14:0] <= r_s;
				shift_reg[15] <= shift_in;
			end else begin
				shift_reg <= shift_reg;
			end
		end else begin
			shift_reg <= SEED_VALUE;
		end
		
	end



endmodule : lfsr
