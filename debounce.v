`default_nettype none
`timescale 1ns/1ns
module debounce (
    input wire clk,
    input wire reset,
    input wire button,
    output reg debounced
);
   
    reg [7:0] shift_reg; 

    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 8'b0; 
            debounced <= 1'b0; 
        end else begin
            shift_reg <= {shift_reg[6:0], button};
            if (shift_reg == 8'b11111111) begin
                debounced <= 1'b1;
            end else begin
            	debounced <= 1'b0;
            end
        end
    end

endmodule
