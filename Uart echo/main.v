module main (
   input           RX,
   input           FT,
   input           RESET,
   
  //output reg TEST_7PIN,
   
   output  [0:6]   Led1,
   output  [0:6]   Led2,
   output          TX,
//   output reg      pllLed,
//   output          PLL100Mhz,
//   output          PLL300Mhz,
   
   output reg      FS1CE,
   output          FS1dataOUT,
   output          FS1leOUT,
   output          FS1clkOUT,
        
   output reg      FS2CE,  
   output          FS2dataOUT,
   output          FS2leOUT,
   output          FS2clkOUT,
   
   output reg      FS3CE,  
   output          FS3dataOUT,
   output          FS3leOUT,
   output          FS3clkOUT,
   
   output reg      FS4CE,  
   output          FS4dataOUT,
   output          FS4leOUT,
   output          FS4clkOUT
  );



parameter ClkFreq  = 150_000_000;
parameter BaudRate = 9600;

reg [31:0] DATA = 32'b0000_0000_0000_0000_0000_0000_0001_0000;
  
//reg [1:0] count_byte = 2'b0;
//always@ ( posedge Send_sig )
//  begin
//    case (count_byte)
//	  0 : DATA[7:0]   <= DataROUT;
//	  1 : DATA[15:8]  <= DataROUT;
//	  2 : DATA[23:16] <= DataROUT;
//	  3 : DATA[31:24] <= DataROUT;
//	default : DATA[31:24] <= 0;
//	endcase
//	count_byte <= count_byte + 1;
//  end


///////////////////////////////////////////////////
//////////// FS1signal generate////////////////////
//FSsigGen FS1sigGen_inst
//(
//              .clkIN      ( CLK25MHz     ), // 
//              .clk2IN     ( CLK50MHz     ),
////              .dataIN     ( DATA ),
//              .Send_sigIN ( Send_sigOUT  ),
//              .nResetIN   ( 1            ),
//                                   
//              .clkOUT     ( FS1clkOUT    ),
//              .dataOUT    ( FS1dataOUT   ),  // 
//              .leOUT      ( FS1leOUT     )   // 
//);
///////////////////////////////////////////////////
//////////// FS3signal generate////////////////////
//FSsigGen FS3sigGen_inst
//(
//              .clkIN      ( CLK25MHz     ), // 
//              .clk2IN     ( CLK50MHz     ),
////              .dataIN     ( DATA ),
//              .Send_sigIN ( Send_sigOUT  ),
//              .nResetIN   ( 1            ),
//                                   
//              .clkOUT     ( FS3clkOUT    ),
//              .dataOUT    ( FS3dataOUT   ),  // 
//              .leOUT      ( FS3leOUT     )   // 
//);
////////////////////////////////////////////////////
//////////////// DataRegister32bit /////////////////
//wire    [31:0] Data32bitOUT;
//wire           Send_sigOUT;
//DataRegister32bit DataRegister32bit_inst
//(
//              .clkIN      ( CLK12MHz     ), // 
//              .dataIN     ( dataOUT      ), // 
//              .storeIN    ( doneOUT      ), // 
//              .dataOUT    ( Data32bitOUT ), // 
//              .resetOUT   ( Send_sigOUT  )  
//);
////////////////////////////////////////////////////
////////////// CD5Hz ///////////////////////////////
wire   CLK5Hz;
clkdiv #(
              .clkfreq    ( ClkFreq      ),
              .outfreq    ( 1            )
) CD5Hz(
			  .clkIN      ( FT           ), 
			  .clkOUT     ( CLK5Hz       )
);
////////////////////////////////////////////////////
////////////// CD100Hz /////////////////////////////
wire   CLK100Hz;
clkdiv #(
              .clkfreq    ( ClkFreq      ),
              .outfreq    ( 100          )
) CD100Hz(
			  .clkIN      ( FT           ), 
			  .clkOUT     ( CLK100Hz     )
);
////////////////////////////////////////////////////
//////////////// CD25MHz ///////////////////////////
wire   CLK25MHz;
clkdiv #(
              .clkfreq    ( ClkFreq      ),
              .outfreq    ( 25_000_000   )
) CD25MHz(
			  .clkIN      ( FT           ), 
			  .clkOUT     ( CLK25MHz     )
);
////////////////////////////////////////////////////
//////////////// CD50MHz ///////////////////////////
wire   CLK50MHz;
clkdiv #(
              .clkfreq    ( ClkFreq      ),
              .outfreq    ( 50_000_000   )
) CD50MHz(
			  .clkIN      ( FT           ), 
			  .clkOUT     ( CLK50MHz     )
);
//////////////////////////////////////////////////////
//////////////// CD100MHz ////////////////////////////
wire   CLK100MHz;
clkdiv #(
              .clkfreq    ( ClkFreq      ),
              .outfreq    ( 100_000_000  )
) CD100MHz(
			  .clkIN      ( FT           ), 
			  .clkOUT     ( CLK100MHz    )
);
//////////////////////////////////////////////////////
//////////////// CD5.760MHz //////////////////////////
wire   CLK5760;
clkdiv #(
              .clkfreq    ( ClkFreq      ),
              .outfreq    ( 5_760_000    )
) CD5MHz(
			  .clkIN      ( FT           ), 
			  .clkOUT     ( CLK5760      )
);
///////////////////////////////////////////////////////
//////////////// CD12MHz //////////////////////////////
wire   CLK12MHz;
 clkdiv #(
              .clkfreq    ( ClkFreq      ),
              .outfreq    ( 12_000_000   )
) CD12MHz(
			  .clkIN      ( FT           ), 
			  .clkOUT     ( CLK12MHz     )
);

//////////////////////////////////////////////////////
//////////////// RXSYNC //////////////////////////////
wire      RXSYNC;
UartRxSync UartRxSync_inst
(
              .clkIN      ( CLK5760      ),	// input  clkIN_sig
              .rxIN       ( RX           ),	// input  rxIN_sig
              .rxOUT      ( RXSYNC       )  // output  rxOUT_sig
);
//////////////////////////////////////////////////////
//////////////// UartRX8N1 ///////////////////////////
reg   [7:0] dataOUT;
wire        doneOUT;

UartRX8N1#( 
              .clkFreq    ( 5_760_000    ),
              .baudRate   ( BaudRate     )
 )UartRX8N1_inst (
              .clkIN      ( CLK5760      ),	// input  clkIN_sig
              .nResetIN   ( RESET        ),	// input  nResetIN_sig
              .rxIN       ( RXSYNC       ),	// input  rxIN_sig                    можно и без Rxsync
              .dataOUT    ( dataOUT      ),	// output [7:0] dataOUT_sig
              .doneOUT    ( doneOUT      ) 	// output  doneOUT_sig
);
////////////////////////////////////////////////////////
//////////////// DataRegister //////////////////////////
reg    [7:0] DataROUT;
wire         Send_sig;
DataRegister DataRegister_inst
(
              .clkIN      ( CLK12MHz     ), // input        clkIN_sig
              .nResetIN   ( RESET        ), // input        nResetIN_sig
              .dataIN     ( ASCII_DATA   ), // input  [7:0] dataOUT
              .storeIN    ( doneOUT      ), // input        storeIN_sig
              .dataOUT    ( DataROUT     ), // output [7:0] dataOUT_sig
              .resetOUT   ( Send_sig     )  // output       resetOUT_sig
);
////////////////////////////////////////////////////////
//////////////// Clk2ToSend ////////////////////////////
wire SEND;
wire wireBusy;
Clk2ToSend Clk2ToSend(
              .clkIN      ( CLK12MHz     ),
              .nResetIN   ( RESET        ),
              .clk2IN     ( CLK5Hz       ), //Send_sig
              .nBusyIN    ( wireBusy     ),
              .sendOUT    ( SEND         ),
); 
////////////////////////////////////////////////////////
//////////////// UartTX8N1 /////////////////////////////
TX_test #(
              .clkFreq    ( 5_760_000    ), //Hz
              .baudRate   ( BaudRate     )
) test(
              .clkIN      ( CLK5760      ),
              .nResetIN   ( RESET        ),
              .dataIN     ( ASCII_DATA   ), //DataROUT
              .sendIN     ( SEND         ),
     
              .txOUT      ( TX           ),
              .nBusyOUT   ( wireBusy     )
);
////////////////////////////////////////////////////////
//////////////// LED ///////////////////////////////////
LED LED_inst
(
              .clkIN      ( CLK100Hz     ) ,	// input  clkIN_sig
              .dataIN     ( ASCII_DATA     ) ,	// input [7:0] DataROUT
              .Led1       ( Led1         ) ,	// output [6:0] Led1_sig
              .Led2       ( Led2         ) 	    // output [6:0] Led2_sig
);

reg [7:0] ASCII_DATA = 0;
ASCIITable ASCIITable_inst
(
			  .clkIN	 ( CLK5Hz 		) ,	// input  clkIN_sig
			  .dataOUT	 ( ASCII_DATA   ) 	// output [7:0] dataOUT_sig
);


//
//reg [7:0]data_led;
//reg count;
//always@ (posedge CLK100Hz) begin : led
// data_led[7:0] <= DataROUT[7:0];
// 
//FS1CE <= 1;
//FS2CE <= 1;
//FS3CE <= 1;
//FS4CE <= 1;
////TEST_7PIN <= 0 ;
//
//if(count == 0)
//	case(data_led[7:4])
//		4'h0 : Led1 <= 7'b1111110;//0 
//		4'h1 : Led1 <= 7'b0110000;//1 
//		4'h2 : Led1 <= 7'b1101101;//2
//		4'h3 : Led1 <= 7'b1111001;//3 
//		4'h4 : Led1 <= 7'b0110011;//4 
//		4'h5 : Led1 <= 7'b1011011;//5 
//		4'h6 : Led1 <= 7'b1011111;//6
//		4'h7 : Led1 <= 7'b1110000;//7 
//		4'h8 : Led1 <= 7'b1111111;//8 
//		4'h9 : Led1 <= 7'b1111011;//9 
//	
//		4'ha : Led1 <= 7'b1110111;//a 
//		4'hb : Led1 <= 7'b0011111;//b 
//		4'hc : Led1 <= 7'b0001101;//c 
//		4'hd : Led1 <= 7'b0111101;//d 
//		4'he : Led1 <= 7'b1001111;//e 
//		4'hf : Led1 <= 7'b1000111;//f 
//      default: Led1 <= 7'b0000_000;//t04ka
//	endcase
//else	if(count == 1)
//	case(data_led[3:0])
//		4'h0 : Led2 <= 7'b1111110;//0 
//		4'h1 : Led2 <= 7'b0110000;//1 
//		4'h2 : Led2 <= 7'b1101101;//2
//		4'h3 : Led2 <= 7'b1111001;//3 
//		4'h4 : Led2 <= 7'b0110011;//4 
//		4'h5 : Led2 <= 7'b1011011;//5 
//		4'h6 : Led2 <= 7'b1011111;//6
//		4'h7 : Led2 <= 7'b1110000;//7 
//		4'h8 : Led2 <= 7'b1111111;//8 
//		4'h9 : Led2 <= 7'b1111011;//9 
//	
//		4'ha : Led2 <= 7'b1110111;//a 
//		4'hb : Led2 <= 7'b0011111;//b 
//		4'hc : Led2 <= 7'b0001101;//c 
//		4'hd : Led2 <= 7'b0111101;//d 
//		4'he : Led2 <= 7'b1001111;//e 
//		4'hf : Led2 <= 7'b1000111;//f 
//      default: Led2 <= 7'b0000_000;//t04ka
//	endcase
// count <= count +1;
//end
// 
//////////////////////////////////////////////////////
////////////// PLL ///////////////////////////////////
//defparam pll_inst.clk0_multiply_by = 4;
//pll pll_inst (
//	  .inclk0 ( FT         ),
//	  .c0     ( PLL100Mhz  ),
//	  .c1     ( PLL300Mhz  )
//);
//
//integer pllCounter = 100_000_000;
//always@ (posedge PLL100Mhz) begin : pll
//  if ( pllCounter == 0 ) 
//   begin
//    pllLed <= !pllLed;
//    pllCounter <= 100_000_000;
//   end
//  else 
//    pllCounter <= pllCounter - 1;
// end

//////////////////////////////////////////////////////
////////////// LED ///////////////////////////////////
//integer LedCounter = 100;
//
//always@ (posedge CLK100MHz) begin 
//  if ( LedCounter == 0 ) begin
//    pllLed <= !pllLed;
//    LedCounter <= 100;
//   end
//  else 
//    LedCounter <= LedCounter - 1;
//end


 
endmodule