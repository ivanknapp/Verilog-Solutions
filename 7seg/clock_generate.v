module clock_generate #
(
	parameter CLOCK_FREQUENCY = 150_000_000,
	parameter BAUD_RATE       = 9600
)
(
	input  clockIN,
	output reg clockOUT = 1'b0
);

localparam HALF_BAUD_CLK_REG_VALUE = (((CLOCK_FREQUENCY / BAUD_RATE) / 2) - 1); //2603
localparam HALF_BAUD_CLK_REG_SIZE  =$clog2(HALF_BAUD_CLK_REG_VALUE); //12  двоичный логарифм с округлением в большую сторону

reg [HALF_BAUD_CLK_REG_SIZE-1:0] ClkCounter = 0;



always @(posedge clockIN) begin : rx_clock_generate
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
endmodule