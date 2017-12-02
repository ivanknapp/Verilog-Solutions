module Clk2ToSend (
	input wire clkIN,
	input wire clk2IN,
	input wire nResetIN,
	input wire nBusyIN,
	
	output reg sendOUT
	);

`define READY    0
`define SENDOUT  1
`define SENDOUT0 2
reg [1:0] state;
	
always @ (posedge clkIN)
	if (~nResetIN)////////////////////////// if reset
	  begin                               //
		state   <= `READY;                //
		sendOUT <= 1'b0;                  // not done
	  end                                 //
	else                                  //
	  case ( state )                      //
		`READY:///////////////////////////// 
		   begin                          //     
			 if (~nBusyIN)                // if TX transmit not done 
			   sendOUT <= 1'b0;           // not done 
			 else                         // if TX transmit done     
			   if (clk2IN)                // and if clk2IN = 1
				 state <= `SENDOUT;       // 
		   end                            //    
		`SENDOUT://///////////////////////// 
			begin                         //      
			  sendOUT <= 1'b1;            // done
			  if (~nBusyIN)               // if TX transmit not done
		     	state <= `SENDOUT0;       //      
			end                           //    
		`SENDOUT0:////////////////////////// 
			begin	                      //         
			  sendOUT <= 1'b0;            // not done
			  if (~clk2IN)                // if clk2IN = 0             
			    state <= `READY;          //
			end                           //   
	endcase/////////////////////////////////
		
endmodule
