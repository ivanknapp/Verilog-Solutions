module DataRegister (
	input wire       clkIN,
	input wire       nResetIN,
	input wire [7:0] dataIN,
	input wire       storeIN,           // front edge, save data
	
	output reg [7:0] dataOUT,
	output reg       resetOUT
	);

`define READY     0
`define RESETOUT  1
reg state;
	
always @ (posedge clkIN)
	if (~nResetIN)///////////////////////// if reset
	  begin                              //
		resetOUT <= 1'b0;                // 0
		dataOUT  <= 8'h0;                // 0
		state    <= `READY;              //
	  end                                //
	else                                 //
	  case (state)                       //
		`READY:////////////////////////////
			begin                        //
			  resetOUT <= 1'b0;          // 0
			  if ( storeIN )             // if RX receive done
			    begin                    //
				  dataOUT <= dataIN;     // 
				  state   <= `RESETOUT;  // 
				end                      //
			end                          //
		`RESETOUT:///////////////////////// 
			begin                        //
			  resetOUT <= 1'b1;          // save data done
			  if ( ~storeIN )            // if storeIN 0
				state <= `READY;         //
			end                          //
	  endcase//////////////////////////////
	
endmodule
