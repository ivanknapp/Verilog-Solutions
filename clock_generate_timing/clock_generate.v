module clock_generate #
(
	parameter CLOCK_FREQUENCY = 48_000_000,
	parameter BAUD_RATE       = 9600
)
(
	input SynchIN,
	input  clockIN,
	output reg clockOUT = 1'b1
);

localparam HALF_BAUD_CLK_REG_VALUE = (((CLOCK_FREQUENCY / BAUD_RATE) / 2) - 1); //2603
localparam HALF_BAUD_CLK_REG_SIZE  =$clog2(HALF_BAUD_CLK_REG_VALUE); //12  двоичный логарифм с округлением в большую сторону

reg [HALF_BAUD_CLK_REG_SIZE-1:0] ClkCounter = 0;




always @(posedge clockIN) begin : rx_clock_generate
if (SynchIN==1) 
	begin
		if(ClkCounter == 0)
			begin
				ClkCounter  <= HALF_BAUD_CLK_REG_VALUE;
				clockOUT    <= ~clockOUT;
			end
		else 
			begin
				ClkCounter <= ClkCounter - 1'b1;
			end
	end
else
	begin
		ClkCounter  <= HALF_BAUD_CLK_REG_VALUE;
		clockOUT <= 0;
	end
end
endmodule