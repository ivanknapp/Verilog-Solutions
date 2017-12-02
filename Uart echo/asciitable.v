module ASCIITable(
	input wire clkIN, 
	output reg [7:0] dataOUT = 8'h00
	);

always @ (posedge clkIN)
	  begin
		if (dataOUT < 8'h7F)
			dataOUT <= dataOUT + 1'b1;
		else
			dataOUT <= 8'h20;
	  end
endmodule
