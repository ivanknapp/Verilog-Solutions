module ASCIITable(
	input wire clkIN, 
	input wire nResetIN, 
	output reg [7:0] dataOUT = 8'h00
	);

always @ (posedge clkIN)
	if (~nResetIN) begin
		dataOUT <= 8'h20;
	end
	else begin
		if (dataOUT < 8'h7F)
			dataOUT <= dataOUT + 1'b1;
		else
			dataOUT <= 8'h20;
	end
	
endmodule
