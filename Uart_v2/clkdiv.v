module clkdiv(
	input wire clkIN,
	output reg clkOUT = 1'b0
	);

parameter clkfreq = 48000000;	// Input frequency, Hz
parameter outfreq = 2;		// Output frequency, Hz
integer count = 0;

always @ (posedge clkIN)
	if (count == 0) begin
		clkOUT <= ~clkOUT;
		count <= (clkfreq / (2*outfreq)) - 1;
	end
	else
		count <= count - 1;

endmodule
