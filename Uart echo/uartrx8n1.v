module UartRX8N1 (
	input wire       clkIN,
	input wire       nResetIN,
	input wire       rxIN,
	output reg [7:0] dataOUT,
	output reg       doneOUT
	);

parameter clkFreq  = 50_000_000;
parameter baudRate = 9600;
	
`define RXREADY       0
`define RXBAUDSTART   1
`define RXSTARTBIT    2
`define RXNOTSTARTBIT 3
`define RXNEXTDATABIT 4
`define RXDATABIT     5
`define RXPRESTOPBIT  6
`define RXSTOPBIT     7
reg [2:0] state;

reg  baudClkOn = 1'b0;
wire baudClkW;


ClkDivEn #(
       .clkFreq    ( clkFreq   ),
       .outFreq    ( baudRate  )
) CDE(
       .clkIN      ( clkIN     ),
       .nResetIN   ( baudClkOn ),
       .clkOUT     ( baudClkW  )
);

reg [3:0] count;
				 
always @ (posedge clkIN)
	if (~nResetIN)                           // low reset level 
	  begin
		dataOUT   <= 8'h00;
		doneOUT   <= 1'b0;                   // receive not done
		baudClkOn <= 1'b0;                   // stop ClkDivEn
		count     <= 4'b1111;                // 15
		state     <= `RXREADY;
	  end
	else 
	  case (state)
		`RXREADY:////////////////////////////// start receive
			if (~rxIN)                       // if RX = 0
			  begin                          //
				baudClkOn <= 1'b1;           // start ClkDivEn
				state     <= `RXBAUDSTART;   //
				doneOUT   <= 1'b0;           // receive not done
			  end                            //
			else                             //
				baudClkOn <= 1'b0;           // stop ClkDivEn
		`RXBAUDSTART://////////////////////////
			if (baudClkW)                    // rise edge in CDE
			  begin                          //
				state <= `RXSTARTBIT;        //
			  end                            //
		`RXSTARTBIT://///////////////////////// startbit detected
			if (~baudClkW)                   // low edge in CDE
			  begin                          //
				if (~rxIN)                   // if RX = 0
				  begin                      //
					state <= `RXNEXTDATABIT; //  
					count <= 4'b1111;        // 15
				  end                        //
				else                         //
				    state <= `RXNOTSTARTBIT; // 
			  end                            //
		`RXNOTSTARTBIT:////////////////////////
			if (rxIN)                        // if RX = 1
			  state <= `RXREADY;             //
		`RXNEXTDATABIT:////////////////////////
			if (baudClkW)                    // 
				begin                        //
			  	  state <= `RXDATABIT;       // 
			      count <= count + 1'b1;     // 0
				end                          //
		`RXDATABIT:////////////////////////////
			if (~baudClkW)                   //
			  begin                          //
			    dataOUT <= { rxIN, dataOUT[7:1] }; // combination RX + data[7:1] Rx bit + 7 bit data
			      if (count == 4'b0111)      // 7
				    state <= `RXPRESTOPBIT;  //
				  else                       //
				    state <= `RXNEXTDATABIT; //
			  end                            //
		`RXPRESTOPBIT://///////////////////////
			if (baudClkW)                    //
			  state <= `RXSTOPBIT;           //
		`RXSTOPBIT:////////////////////////////
			if (~baudClkW)                   //
			  begin                          //
			    if (rxIN)                    //
			      begin                      //
					doneOUT <= 1'b1;         // receive done
				  end                        //
			    state <= `RXREADY;           //
			  end                            //
	  endcase//////////////////////////////////

endmodule
