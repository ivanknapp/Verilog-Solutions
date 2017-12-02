module UartRxSync (
	input wire clkIN,
	input wire rxIN,
	output wire rxOUT
);

reg [1:0] sync;
assign rxOUT = sync[1];

always @ (posedge clkIN)
	sync <= { sync[0], rxIN };

endmodule