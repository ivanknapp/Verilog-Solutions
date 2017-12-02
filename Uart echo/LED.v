module LED
(
  input            clkIN,
  input      [7:0] dataIN,
    
  output reg [6:0] Led1,
  output reg [6:0] Led2 
);


reg [7:0] data_led;
reg       count;

always@ (posedge clkIN) begin : led
data_led[7:0] <= dataIN[7:0];

if(count == 0)
	case(data_led[7:4])
		4'h0 : Led1 <= 7'b1111110;//0 
		4'h1 : Led1 <= 7'b0110000;//1 
		4'h2 : Led1 <= 7'b1101101;//2
		4'h3 : Led1 <= 7'b1111001;//3 
		4'h4 : Led1 <= 7'b0110011;//4 
		4'h5 : Led1 <= 7'b1011011;//5 
		4'h6 : Led1 <= 7'b1011111;//6
		4'h7 : Led1 <= 7'b1110000;//7 
		4'h8 : Led1 <= 7'b1111111;//8 
		4'h9 : Led1 <= 7'b1111011;//9 
	
		4'ha : Led1 <= 7'b1110111;//a 
		4'hb : Led1 <= 7'b0011111;//b 
		4'hc : Led1 <= 7'b0001101;//c 
		4'hd : Led1 <= 7'b0111101;//d 
		4'he : Led1 <= 7'b1001111;//e 
		4'hf : Led1 <= 7'b1000111;//f 
      default: Led1 <= 7'b0000_000;//t04ka
	endcase
else	if(count == 1)
	case(data_led[3:0])
		4'h0 : Led2 <= 7'b1111110;//0 
		4'h1 : Led2 <= 7'b0110000;//1 
		4'h2 : Led2 <= 7'b1101101;//2
		4'h3 : Led2 <= 7'b1111001;//3 
		4'h4 : Led2 <= 7'b0110011;//4 
		4'h5 : Led2 <= 7'b1011011;//5 
		4'h6 : Led2 <= 7'b1011111;//6
		4'h7 : Led2 <= 7'b1110000;//7 
		4'h8 : Led2 <= 7'b1111111;//8 
		4'h9 : Led2 <= 7'b1111011;//9 
	
		4'ha : Led2 <= 7'b1110111;//a 
		4'hb : Led2 <= 7'b0011111;//b 
		4'hc : Led2 <= 7'b0001101;//c 
		4'hd : Led2 <= 7'b0111101;//d 
		4'he : Led2 <= 7'b1001111;//e 
		4'hf : Led2 <= 7'b1000111;//f 
      default: Led2 <= 7'b0000_000;//t04ka
	endcase
 count <= count +1;
end
endmodule