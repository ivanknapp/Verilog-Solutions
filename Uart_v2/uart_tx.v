module UartTX(baudClkX2, nResetIN, dataIN, sendIN, txOUT, nBusyOUT);
input baudClkX2, nResetIN, sendIN;
input [7:0] dataIN;
output txOUT, nBusyOUT;

reg txOUT = 1'b1;
reg nBusyOUT = 1'b1;
reg [7:0] data;
reg [3:0] bitCnt;

`define READY    0
`define STARTBIT 1
`define SENDDATABIT 2
`define NEXTDATABIT 3
`define LASTDATABIT 4
`define STOPBIT 5
`define NEXTSTOPBIT 6
reg [3:0] state;

always @ (posedge baudClkX2)
	if (~nResetIN) begin
		txOUT <= 1'b1;
		nBusyOUT <= 1'b0;
		state <= `READY;
	end
	else case (state)
		`READY:
			if (~sendIN) begin
				txOUT <= 1'b1;
				nBusyOUT <= 1'b1;
				state <= `READY;
			end
			else begin
				txOUT <= 1'b0;
				nBusyOUT <= 1'b0;
				data <= dataIN;
				bitCnt <= 0;
				state <= `STARTBIT;
			end
		`STARTBIT: begin
				state <= `SENDDATABIT;
			end
		`SENDDATABIT: begin
				txOUT <= data[bitCnt];
				if (bitCnt == 7)
					state <= `LASTDATABIT;
				else
					state <= `NEXTDATABIT;
			end
		`NEXTDATABIT: begin
				bitCnt <= bitCnt + 1;
				state <= `SENDDATABIT;
			end
		`LASTDATABIT: begin
				state <= `STOPBIT;
			end
		`STOPBIT: begin
				txOUT <= 1'b1;
				state <= `NEXTSTOPBIT;
			end
		`NEXTSTOPBIT: begin
				if (sendIN) begin
					state <= `NEXTSTOPBIT;
					nBusyOUT <= 1'b1;
				end
				else
					state <= `READY;
			end
	endcase
	
endmodule
	