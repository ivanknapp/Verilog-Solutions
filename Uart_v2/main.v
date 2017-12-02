module main (
   input FT,
   input RESET,
   output TX
);


wire baudClk2;
defparam CD.clkfreq = 48_000_000;
defparam CD.outfreq = 2;
clkdiv CD(
			 .clkIN      ( FT        ), 
			 .clkOUT     ( baudClk2  )
);
defparam test.clkFreq = 48_000_000;
defparam test.baudRate = 9600;
TX_test test(
              .clkIN     ( FT        ),
              .nResetIN  (1          ),
              .dataIN    ( dataOUT   ),
              .sendIN    ( SEND      ),
     
              .txOUT     ( TX        ),
              .nBusyOUT  ( wireBusy  )
    );

reg [7:0]dataOUT = 8`b0;
ASCIITable ASCIITable(
              .clkIN     ( baudClk2  ), 
              .nResetIN  ( 1         ), 
              .dataOUT   ( dataOUT   )
    );

wire SEND;
wire wireBusy;
 Clk2ToSend Clk2ToSend(
              .clkIN     ( FT        ),
              .nResetIN  (1          ),
              .clk2IN    ( baudClk2  ), 
              .nBusyIN   ( wireBusy  ),
              .sendOUT   ( SEND      ),
    );


endmodule