module ClkDivEn(
	input wire clkIN,
	input wire nResetIN,
	output reg clkOUT = 1'b0
	);

parameter clkFreq = 48_000_000;	// Input frequency, Hz
parameter outFreq = 2;          // Output frequency, Hz
integer   count;

always @ (posedge clkIN)
	if (~nResetIN) 
	  begin
		clkOUT <= 1'b0;
		count  <= 0;
	  end
	else 
	  if (count == 0) 
	    begin
		  clkOUT <= ~clkOUT;
		  count  <= ( clkFreq / ( 2*outFreq ) ) - 1;
	    end
	  else
		count <= count - 1;

endmodule
