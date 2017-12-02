module DataRegister32bit (
	input wire       clkIN,
	input wire [7:0] dataIN,
	input wire       storeIN,           // front edge, save data
	
	output reg [31:0] dataOUT,
	output reg        resetOUT
	);

`define READY     0
`define LOADBYTE  1
`define NEXTBYTE  2
`define DONEOUT   3
reg       state          = `READY;

reg [1:0] count_byte     = 0;


always @ (posedge clkIN)
	  case (state)                       
		`READY://///////////////////////////////////                                 
			begin                                 //
			  resetOUT <= 1'b0;                   // 0
			  if ( storeIN )                      // if RX receive done
			    state <= `LOADBYTE;               //                      
			  else                                // 
			    state <= `READY;                  //                              
			end                                   //
		`LOADBYTE://////////////////////////////////
		    begin                                 //
			  case (count_byte)                   //
				0 : dataOUT[7:0]   <= dataIN;     //
				1 : dataOUT[15:8]  <= dataIN;     //
				2 : dataOUT[23:16] <= dataIN;     //
				3 : dataOUT[31:24] <= dataIN;     //
			    default : dataOUT[31:24] <= 0;    //
			  endcase			                  //               
			  state <= `NEXTBYTE;                 //                                  
	        end                                   //
	    `NEXTBYTE://////////////////////////////////
	        begin
	        if ( storeIN )                                 //
	          if ( count_byte != 3 )              //                  
	            begin                             //    
	              count_byte <= count_byte + 1;   //
	              state     <= `READY;            // LOADBYTE
	            end                               //  
	          else                                // 
	            begin                             //    
	              count_byte <= 0;                //
	              state      <= `DONEOUT;         //
	            end                               //  
	        end                                   //   
		`DONEOUT://///////////////////////////////// 
			begin                                 //
			  resetOUT <= 1'b1;                   // save data done
			  if ( ~storeIN )                     // if storeIN 0 state READY
				state <= `READY;                  //
			  else                                //
			    state <= `DONEOUT;                // if storeIN 1 state DONEOUT
			end                                   //
	  endcase///////////////////////////////////////
	
endmodule
