`default_nettype none
`timescale 1ns/1ns
module encoder (
    input clk,
    input reset,
    input a,
    input b,
    output reg [7:0] value
);
   
   reg old_a;
   reg old_b;
   wire [3:0] EQ;
   
   always@(posedge clk)begin
      if(reset)begin
        old_a <= 1'b0;
        old_b <= 1'b0;
      end else begin
        old_a <= a;
        old_b <= b;
      end
   end
   
   assign EQ = {a, old_a, b, old_b};
   
   always@(posedge clk)begin
   	if(reset)begin
   	  value <= 8'b0;
   	end else begin
   	  case(EQ)
   	   1000: value <= value + 1;
   	   0111: value <= value + 1;
   	   0010: value <= value - 1;
   	   1101: value <= value - 1;
   	   default:
   	   	value <= value;
   	  endcase
   	end
   end
        

endmodule
