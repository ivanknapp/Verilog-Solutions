module Clk2ToSend (
	input wire clkIN,
	input wire nResetIN,
	input wire clk2IN,
	input wire nBusyIN,
	output reg sendOUT
	);

`define READY 0
`define SENDOUT 1
`define SENDOUT0 2
reg [1:0] state;
	
always @ (posedge clkIN)
	if (~nResetIN) begin
		state <= `READY;
		sendOUT <= 1'b0;
	end
	else case (state)
		`READY: begin
				if (~nBusyIN)
					sendOUT <= 1'b0;
				else if (clk2IN)
					state <= `SENDOUT;
			end
		`SENDOUT: begin
				sendOUT <= 1'b1;
				if (~nBusyIN)
					state <= `SENDOUT0;
			end
		`SENDOUT0: begin	
				sendOUT <= 1'b0;
				if (~clk2IN)
					state <= `READY;
			end
	endcase
		
endmodule
