module main
(
	input SynchIN,
	input FT,
	output reg clk_gen_out
	
);



defparam clock_generate.CLOCK_FREQUENCY = 48_000_000;
defparam clock_generate.BAUD_RATE       = 9600;
clock_generate clock_generate 
(
	.SynchIN(SynchIN),
	.clockIN(FT),
	.clockOUT(clk_gen_out),
);




endmodule