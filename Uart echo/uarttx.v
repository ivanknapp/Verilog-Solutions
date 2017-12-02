module UartTX(baudClkX2, nResetIN, dataIN, sendIN, txOUT, nBusyOUT);
input baudClkX2, nResetIN, sendIN;
input [7:0] dataIN;
output txOUT, nBusyOUT;

reg       txOUT    = 1'b1;
reg       nBusyOUT = 1'b1;
reg [7:0] data;
reg [3:0] bitCnt;
reg [13:0] timer_count = 0;

`define READY       0
`define STARTBIT    1
`define SENDDATABIT 2
`define NEXTDATABIT 3
`define LASTDATABIT 4
`define STOPBIT     5
`define NEXTSTOPBIT	6
//`define TIMER       7
reg [3:0] state;

always @ (posedge baudClkX2)
if (~nResetIN)/////////////////////////////// if reset                                                                                          
  begin                                    //                            
    txOUT    <= 1'b1;                      // TX = 1                                         
    nBusyOUT <= 1'b0;                      // transmit not done                                         
	state    <= `READY;                    //                                            
  end                                      //                          
else                                       //
  case (state)                             //   
	`READY://////////////////////////////////                          
		if (~sendIN)                       // if sendIN = 0         
		  begin                            //                                                                    
			txOUT    <= 1'b1;              // TX = 1              
			nBusyOUT <= 1'b1;              // transmit done  ???????????????                
			state    <= `READY;            //                 
		  end                              //                                  
		else                               //                                  
		  begin                            // if sendIN = 1                                   
			txOUT    <= 1'b0;              // TX = 0, STARTBIT
			nBusyOUT <= 1'b0;              // transmit NOT done                 
			data     <= dataIN;            // load data register               
			bitCnt   <= 0;                 // bit Cnt 0            
			state    <= `STARTBIT;         //                          
		  end                              //  
	`STARTBIT:///////////////////////////////                                                           
		begin                              //  
			state <= `SENDDATABIT;         //                              
		end                                //
	`SENDDATABIT: ///////////////////////////                                                          
		begin                              //  
		  txOUT <= data[bitCnt];           // TX = data[bitCnt]                   
		  if (bitCnt == 7)                 //               
		    state <= `LASTDATABIT;         //                              
		  else                             //                                   
			state <= `NEXTDATABIT;         //                              
		end                                //
	`NEXTDATABIT:////////////////////////////                           
		begin                              //  
		  bitCnt <= bitCnt + 1;            // bitCnt + 1                    
		  state  <= `SENDDATABIT;          //                            
		end                                //                                
	`LASTDATABIT:////////////////////////////                          
		begin                              //  
		  state <= `STOPBIT;               //                       
		end                                //
	`STOPBIT:////////////////////////////////                                                                                                                   
		begin                              //  
		  txOUT <= 1'b1;                   // TX = 1            
		  state <= `NEXTSTOPBIT;           // <<<<< state `TIMER                      
		end                                // <<<<< ÑÞÄÀ ÄÎÁÀÂÈÒÜ ÒÀÉÌÅÐ		
    `NEXTSTOPBIT:////////////////////////////
		begin                              //                                                                 
		  if (sendIN)                      // if sendIN = 1           
		    begin                          //                                      
			  state    <= `NEXTSTOPBIT;    //
			  nBusyOUT <= 1'b1;            // transmit done                                                   
			end                            //                                   
		  else                             // if sendIN = 0                                 
		    state <= `READY;               //                 
		end                                //
//	`TIMER://////////////////////////////////
//		begin							   //
//			if (timer_count != 2400)       //
//				timer_count = timer_count + 1;
//			else                           //
//				begin                      //
//				  timer_count = 0;         //
//				  state <= `READY;         //
//				end                        //
//		end                                //
  endcase////////////////////////////////////
	
endmodule
	