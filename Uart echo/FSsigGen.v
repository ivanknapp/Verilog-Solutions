module FSsigGen
(
  input          clkIN,
  input          clk2IN,
  //input   [31:0] dataIN,
  input          Send_sigIN,
  input          nResetIN,
  
  output reg     startSigIN,
  output reg     clkOUT,
  output reg     dataOUT,
  output reg     leOUT
);

////////////////////////////////////////////////////
////////////// FS1CLK generate//////////////////////
always@ (negedge clk2IN)
begin
  if ( leOUT == 0 )
    if ( clkIN == 1 && clk2IN == 0 )
      clkOUT <= 1;
    else
      clkOUT <= 0;
  else
    clkOUT <= 0;
end
////////////////////////////////////////////////////
//////////// FSsignal generate//////////////////////
//                              0123..................................31//
reg [31:0] dataIN           = 32'b0000_0000_0000_0000_0000_0000_0001_0000;

//always @(posedge clkIN)
//begin
//  TestCLK <= !TestCLK;
//end

integer count_data_bit = 0;
always @(posedge clkIN) 
	begin
	  case(count_data_bit)
		0 :begin dataOUT <= dataIN[0];  leOUT <= 0; end//
		1 :begin dataOUT <= dataIN[1];  leOUT <= 0; end//
		2 :begin dataOUT <= dataIN[2];  leOUT <= 0; end//
		3 :begin dataOUT <= dataIN[3];  leOUT <= 0; end//
		4 :begin dataOUT <= dataIN[4];  leOUT <= 0; end//
		5 :begin dataOUT <= dataIN[5];  leOUT <= 0; end//
		6 :begin dataOUT <= dataIN[6];  leOUT <= 0; end//
		7 :begin dataOUT <= dataIN[7];  leOUT <= 0; end//
		8 :begin dataOUT <= dataIN[8];  leOUT <= 0; end//
		9 :begin dataOUT <= dataIN[9];  leOUT <= 0; end//
	   10 :begin dataOUT <= dataIN[10]; leOUT <= 0; end//
	   11 :begin dataOUT <= dataIN[11]; leOUT <= 0; end//
	   12 :begin dataOUT <= dataIN[12]; leOUT <= 0; end//
	   13 :begin dataOUT <= dataIN[13]; leOUT <= 0; end//
	   14 :begin dataOUT <= dataIN[14]; leOUT <= 0; end//
	   15 :begin dataOUT <= dataIN[15]; leOUT <= 0; end//
	   16 :begin dataOUT <= dataIN[16]; leOUT <= 0; end//
	   17 :begin dataOUT <= dataIN[17]; leOUT <= 0; end//
	   18 :begin dataOUT <= dataIN[18]; leOUT <= 0; end//
	   19 :begin dataOUT <= dataIN[19]; leOUT <= 0; end//
	   20 :begin dataOUT <= dataIN[20]; leOUT <= 0; end//
	   21 :begin dataOUT <= dataIN[21]; leOUT <= 0; end//
	   22 :begin dataOUT <= dataIN[22]; leOUT <= 0; end//
	   23 :begin dataOUT <= dataIN[23]; leOUT <= 0; end//
	   24 :begin dataOUT <= dataIN[24]; leOUT <= 0; end//
	   25 :begin dataOUT <= dataIN[25]; leOUT <= 0; end//
	   26 :begin dataOUT <= dataIN[26]; leOUT <= 0; end//
	   27 :begin dataOUT <= dataIN[27]; leOUT <= 0; end//
	   28 :begin dataOUT <= dataIN[28]; leOUT <= 0; end//
	   29 :begin dataOUT <= dataIN[29]; leOUT <= 0; end//
	   30 :begin dataOUT <= dataIN[30]; leOUT <= 0; end//
	   31 :begin dataOUT <= dataIN[31]; leOUT <= 0; end//
	   32 :begin dataOUT <= 0;          leOUT <= 1; end//
	   33 :begin dataOUT <= 0;          leOUT <= 1; end//
	   default :begin dataOUT <= 0;     leOUT <= 1; end//
	  endcase
	  count_data_bit <= count_data_bit+1;
	  if (count_data_bit >= 34)
		count_data_bit <= 0;
	  else
	    count_data_bit <= count_data_bit+1;	
	  
	end
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//reg      startSigIN = 0;
//reg [1:0]count_byte = 0;
//always @ ( posedge Send_sigIN )
//  begin
//	  if ( count_byte == 3 )
//	    startSigIN <= 1;
//	  else 
//        startSigIN <= 0;
//      count_byte= count_byte + 1;
//  end  
//  
//  
//reg [31:0] data;
//reg [4:0]  bitCnt;
//
//`define READY       0
//`define STARTBIT    1
//`define SENDDATABIT 2
//`define NEXTDATABIT 3
//`define LASTDATABIT 4
//`define STOPBIT     5
//`define NEXTSTOPBIT 6
//reg [3:0] state;
//
//always @ (posedge clk2IN)
//if (~nResetIN)/////////////////////////////// if reset                                                                                          
//  begin                                    //                            
//    dataOUT  <= 1'b0;                      // TX = 1                                         
//    leOUT    <= 1'b1;                      // transmit not done                                         
//	state    <= `READY;                    //                                            
//  end                                      //                          
//else                                       //
//  case (state)                             //   
//	`READY://////////////////////////////////                          
//		if (~Send_sigIN)                   // if sendIN = 0         
//		  begin                            //                                                                    
//			dataOUT  <= 1'b0;              // TX = 1              
//			leOUT    <= 1'b1;              // transmit done  ???????????????                
//			state    <= `READY;            //                 
//		  end                              //                                  
//		else                               //                                  
//		  begin                            // if sendIN = 1                                   
//			dataOUT  <= 1'b0;              // TX = 0, STARTBIT
//			leOUT    <= 1'b0;              // transmit NOT done                 
//			data     <= dataIN;            // load data register               
//			bitCnt   <= 0;                 // bit Cnt 0            
//			state    <= `SENDDATABIT;      //                          
//		  end                              //  
//	`SENDDATABIT: ///////////////////////////                                                          
//		begin                              //  
//		  dataOUT <= data[bitCnt];         // TX = data[bitCnt]                   
//		  if (bitCnt == 31)                //               
//		    state <= `LASTDATABIT;         //                              
//		  else                             //                                   
//			state <= `NEXTDATABIT;         //                              
//		end                                //
//	`NEXTDATABIT:////////////////////////////                           
//		begin                              //  
//		  bitCnt <= bitCnt + 1;            // bitCnt + 1                    
//		  state  <= `SENDDATABIT;          //                            
//		end                                //                                
//	`LASTDATABIT:////////////////////////////                          
//		begin                              //  
//		  state <= `STOPBIT;               //                       
//		end                                //
//	`STOPBIT:////////////////////////////////                                                                                                                   
//		begin                              //  
//		  dataOUT  <= 1'b0;                //
//		  leOUT    <= 1'b1;                // TX = 1            
//		  state <= `NEXTSTOPBIT;           //                          
//		end                                //
//    `NEXTSTOPBIT:////////////////////////////
//		begin                              //                                                                 
//		  if (startSigIN)                  // if sendIN = 1                                           
//			state <= `NEXTSTOPBIT;         //                                                             
//		  else                             // if sendIN = 0                                 
//		    state <= `READY;               //                 
//		end                                //
//  endcase////////////////////////////////////
endmodule 