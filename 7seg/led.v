module led
(
input              CLOCK_IN,
input              reset,
output reg  [7:0]  ROW_LED,
output reg  [7:0]  COL_LED,
output reg  [11:0] LED
);

//reg [2:0] cnt_led = 0;
//
//always @(posedge CLOCK_IN) begin cnt
// if ( reset == 0 ) then
//  cnt_led <= 0;
// else 
//  cnt_led <= cnt_led + 1;
//end

reg clk;	   
reg [3:0]count=0;
defparam  clock_generate.CLOCK_FREQUENCY  = 50_000_000;
defparam  clock_generate.BAUD_RATE  = 100;
clock_generate clock_generate
(
	.clockIN(CLOCK_IN),
	.clockOUT(clk)
);




//always @(posedge clk)begin :led
//  LEDY <= 8'b  00000000;
//  LEDX <= 8'b  11111110;
//
//end

//always @(posedge clk)begin :led
//   if (count == 0) begin
//			LED <= 12'b1001_0010_1110;//5
//			COL_LED[0] <= 1; COL_LED[1] <= 0; COL_LED[2] <= 1; COL_LED[3] <= 1; COL_LED[4] <= 1; COL_LED[5] <= 1; COL_LED[6] <= 1; COL_LED[7] <= 1;
//			
//			ROW_LED[1] <= 0;
//			ROW_LED[2] <= 0;
//			ROW_LED[3] <= 0;
//			ROW_LED[4] <= 0;
//			ROW_LED[5] <= 0;
//			ROW_LED[6] <= 0;
//			ROW_LED[7] <= 1;
//
//		end	
//   else if (count == 1) begin
//			LED <= 12'b1000_0010_1101;//6
//			COL_LED[0] <= 1; COL_LED[1] <= 1; COL_LED[2] <= 0; COL_LED[3] <= 1; COL_LED[4] <= 1; COL_LED[5] <= 1; COL_LED[6] <= 1; COL_LED[7] <= 1;
//						
//			ROW_LED[0] <= 1;
//			ROW_LED[1] <= 0;
//			ROW_LED[2] <= 0;
//			ROW_LED[3] <= 0;
//			ROW_LED[4] <= 0;
//			ROW_LED[5] <= 0;
//			ROW_LED[6] <= 0;
//			ROW_LED[7] <= 1;
//			
//	end
//   else if (count == 2) begin
//			 LED <= 12'b1000_0010_1101;//6
//			COL_LED[0] <= 1; COL_LED[1] <= 1; COL_LED[2] <= 1; COL_LED[3] <= 0; COL_LED[4] <= 1; COL_LED[5] <= 1; COL_LED[6] <= 1; COL_LED[7] <= 1;
//
//			ROW_LED[0] <= 1;
//			ROW_LED[1] <= 1;
//			ROW_LED[2] <= 1;
//			ROW_LED[3] <= 0;
//			ROW_LED[4] <= 0;
//			ROW_LED[5] <= 0;
//			ROW_LED[6] <= 1;
//			ROW_LED[7] <= 1;
//
//	end
//   else if (count == 3) begin
//			 LED <= 12'b1000_0010_1101;//6
//			COL_LED[0] <= 1; COL_LED[1] <= 1; COL_LED[2] <= 1; COL_LED[3] <= 1; COL_LED[4] <= 0; COL_LED[5] <= 1; COL_LED[6] <= 1; COL_LED[7] <= 1;
//
//			ROW_LED[0] <= 1;
//			ROW_LED[1] <= 1;
//			ROW_LED[2] <= 0;
//			ROW_LED[3] <= 0;
//			ROW_LED[4] <= 1;
//			ROW_LED[5] <= 0;
//			ROW_LED[6] <= 0;
//			ROW_LED[7] <= 1;
//			
//	end
//   else if (count == 4) begin
//			 LED <= 12'b1000_0010_1101;//6
//			COL_LED[0] <= 1; COL_LED[1] <= 1; COL_LED[2] <= 1; COL_LED[3] <= 1; COL_LED[4] <= 1; COL_LED[5] <= 0; COL_LED[6] <= 1; COL_LED[7] <= 1;
//			
//			ROW_LED[0] <= 1;
//			ROW_LED[1] <= 0;
//			ROW_LED[2] <= 0;
//			ROW_LED[3] <= 1;
//			ROW_LED[4] <= 1;
//			ROW_LED[5] <= 1;
//			ROW_LED[6] <= 0;
//			ROW_LED[7] <= 1;
//	end
//   else if (count == 5) begin
//			 LED <= 12'b1000_0010_1101;//6
//			COL_LED[0] <= 1; COL_LED[1] <= 1; COL_LED[2] <= 1; COL_LED[3] <= 1; COL_LED[4] <= 1; COL_LED[5] <= 1; COL_LED[6] <= 0; COL_LED[7] <= 1;
//			
//			ROW_LED[0] <= 1;
//			ROW_LED[1] <= 0;
//			ROW_LED[2] <= 1;
//			ROW_LED[3] <= 1;
//			ROW_LED[4] <= 1;
//			ROW_LED[5] <= 1;
//			ROW_LED[6] <= 1;
//			ROW_LED[7] <= 1;
//	end
//	
//			count <= count +1;
//end


//always @(CLOCK_IN) begin :counter
//	if (PLL_counter == 100_000_000) 
//		begin
//			PLL_counter = 0;
//			clk = clk + 1;
//		end
//	else
//		PLL_counter = PLL_counter + 1;
//end

//////////////////////////////// PICTURE
always @(posedge clk)
  begin :led
		
		if (count==0) begin
			LED <= 12'b1111_1001_1110;//1
			ROW_LED <= 8'b1110_0111;
			COL_LED <= 8'b1110_0111;
		end
		else if (count == 1) begin
			LED <= 12'b1010_0100_1101;//2
			ROW_LED <= 8'b1100_0011;
			COL_LED <= 8'b1100_0011;
		end
		else if (count == 2) begin
			LED <= 12'b1011_0000_1011;//3
			ROW_LED <= 8'b1001_1001;
			COL_LED <= 8'b1001_1001;
		end
		else if (count == 3) begin
			LED <= 12'b1001_1001_0111;//4
			ROW_LED <= 8'b0011_1100;
			COL_LED <= 8'b0011_1100;
		end	
		else if (count == 4) begin
			LED <= 12'b1001_0010_1110;//5
			ROW_LED <= 8'b0111_1110;
			COL_LED <= 8'b0111_1110;
		end	
		else if (count == 5) begin
			LED <= 12'b1000_0010_1101;//6
			ROW_LED <= 8'b1011_1101;
			COL_LED <= 8'b1011_1101;
		end	
		else if (count == 6) begin
			LED <= 12'b1111_1000_1011;//7
			ROW_LED <= 8'b1101_1011;
			COL_LED <= 8'b1101_1011;
		end	
		else if (count == 7) begin
			LED <= 12'b1000_0000_0111;//8
			ROW_LED <= 8'b1111_0111;
			COL_LED <= 8'b1110_1111;
		end	
		count <= count +1;
end
//
//////////////////////////////////////  FFcF
//if (count==0)
//	case(data[15:12])
//		4'h0 : LED <= 12'b1100_0000_1110;//0
//		4'h1 : LED <= 12'b1111_1001_1110;//1
//		4'h2 : LED <= 12'b1010_0100_1110;//2
//		4'h3 : LED <= 12'b1011_0000_1110;//3
//		4'h4 : LED <= 12'b1001_1001_1110;//4
//		4'h5 : LED <= 12'b1001_0010_1110;//5
//		4'h6 : LED <= 12'b1000_0010_1110;//6
//		4'h7 : LED <= 12'b1111_1000_1110;//7
//		4'h8 : LED <= 12'b1000_0000_1110;//8
//		4'h9 : LED <= 12'b1001_0000_1110;//9
//
//		4'ha: LED <= 12'b1000_1000_1110;//a
//		4'hb: LED <= 12'b1000_0011_1110;//b
//		4'hc: LED <= 12'b1010_0111_1110;//c
//		4'hd: LED <= 12'b1010_0001_1110;//d
//		4'he: LED <= 12'b1000_0110_1110;//e
//		4'hf: LED <= 12'b1000_1110_1110;//f
//		default: LED <= 12'b0111_1111_1110;//точка
//	endcase
//else	if(count == 1)
//	case(data[11:8])
//		4'h0 : LED <= 12'b1100_0000_1101;//0
//		4'h1 : LED <= 12'b1111_1001_1101;//1
//		4'h1 : LED <= 12'b1111_1001_1101;//1
//		4'h2 : LED <= 12'b1010_0100_1101;//2
//		4'h3 : LED <= 12'b1011_0000_1101;//3
//		4'h4 : LED <= 12'b1001_1001_1101;//4
//		4'h5 : LED <= 12'b1001_0010_1101;//5
//		4'h6 : LED <= 12'b1000_0010_1101;//6
//		4'h7 : LED <= 12'b1111_1000_1101;//7
//		4'h8 : LED <= 12'b1000_0000_1101;//8
//		4'h9 : LED <= 12'b1001_0000_1101;//9
//	
//		4'ha: LED <= 12'b1000_1000_1101;//a
//		4'hb: LED <= 12'b1000_0011_1101;//b
//		4'hc: LED <= 12'b1010_0111_1101;//c
//		4'hd: LED <= 12'b1010_0001_1101;//d
//		4'he: LED <= 12'b1000_0110_1101;//e
//		4'hf: LED <= 12'b1000_1110_1101;//f
//		default: LED <= 12'b0111_1111_1101;//точка
//	endcase
//else	if(count == 2)
//	case(data[7:4])
//		4'h0 : LED <= 12'b1100_0000_1011;//0
//		4'h1 : LED <= 12'b1111_1001_1011;//1
//		4'h1 : LED <= 12'b1111_1001_1011;//1
//		4'h2 : LED <= 12'b1010_0100_1011;//2
//		4'h3 : LED <= 12'b1011_0000_1011;//3
//		4'h4 : LED <= 12'b1001_1001_1011;//4
//		4'h5 : LED <= 12'b1001_0010_1011;//5
//		4'h6 : LED <= 12'b1000_0010_1011;//6
//		4'h7 : LED <= 12'b1111_1000_1011;//7
//		4'h8 : LED <= 12'b1000_0000_1011;//8
//		4'h9 : LED <= 12'b1001_0000_1011;//9
//		
//		4'ha: LED <= 12'b1000_1000_1011;//a
//		4'hb: LED <= 12'b1000_0011_1011;//b
//		4'hc: LED <= 12'b1010_0111_1011;//c
//		4'hd: LED <= 12'b1010_0001_1011;//d
//		4'he: LED <= 12'b1000_0110_1011;//e
//		4'hf: LED <= 12'b1000_1110_1011;//f
//		default: LED <= 12'b0111_1111_1011;//oi?ea
//	endcase
//else	if(count == 3)
//	case(data[3:0])
//		4'h0 : LED <= 12'b1100_0000_0111;//0
//		4'h1 : LED <= 12'b1111_1001_0111;//1
//		4'h1 : LED <= 12'b1111_1001_0111;//1
//		4'h2 : LED <= 12'b1010_0100_0111;//2
//		4'h3 : LED <= 12'b1011_0000_0111;//3
//		4'h4 : LED <= 12'b1001_1001_0111;//4
//		4'h5 : LED <= 12'b1001_0010_0111;//5
//		4'h6 : LED <= 12'b1000_0010_0111;//6
//		4'h7 : LED <= 12'b1111_1000_0111;//7
//		4'h8 : LED <= 12'b1000_0000_0111;//8
//		4'h9 : LED <= 12'b1001_0000_0111;//9
//		
//		4'ha: LED <= 12'b1000_1000_0111;//a
//		4'hb: LED <= 12'b1000_0011_0111;//b
//		4'hc: LED <= 12'b1010_0111_0111;//c
//		4'hd: LED <= 12'b1010_0001_0111;//d
//		4'he: LED <= 12'b1000_0110_0111;//e
//		4'hf: LED <= 12'b1000_1110_0111;//f
//		default: LED <= 12'b0111_1111_0111;//oi?ea
//	endcase
// count <= count +1;
//
//end

endmodule