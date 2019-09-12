// Output to display module asyncronous
// Includes a 2bits counter/decoder, 
// display_mode select (dec/hex) 
// and 4 seven segment display output

// Antonio Sanchez

module outdisplay
  (input disp_mode,
	input clk,
   input [7:0]int_reg,
   output reg [3:0] cc,
   output [7:0] anode
  );
  
  
  
  reg [7:0] rom [2047:0];
  reg [1:0] int_counter;
   
  assign anode = rom [{disp_mode,int_counter,int_reg}];
  
  initial 
	$readmemh ("displayHEX.txt",rom);
  
 
  always @(posedge clk) begin
  case (int_counter)
	2'b01: begin int_counter<=2'b10; cc<= 4'b1011; end
	2'b10: begin int_counter<=2'b11; cc<= 4'b0111; end
	2'b11: begin int_counter<=2'b00; cc<= 4'b1110; end
	default: begin int_counter<=2'b01; cc<= 4'b1101;end
	endcase
	end
endmodule