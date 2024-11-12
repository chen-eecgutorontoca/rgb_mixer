`default_nettype none
`timescale 1ns/1ns
module pwm (
    input wire clk,
    input wire reset,
    output wire out,
    input wire [7:0] level
    );
    
    reg [7:0] cnt;
    reg out_reg;
    
    always@(posedge clk)begin
    	if(reset)
    	  cnt <= 8'b0;
    	else if(cnt==255)
          cnt <= 8'b0;
        else
          cnt <= cnt + 1;
   end
   
   always@(posedge clk)begin
   	if(reset)
   	  out_reg <= 1'b0;
        else if(cnt<level)
          out_reg <= 1'b1;
        else
          out_reg <= out_reg;
  end
  
  assign out = out_reg;

endmodule
