`default_nettype none
`timescale 1ns/1ns

module rgb_mixer (
    input wire clk,
    input wire reset,
    input wire enc0_a,
    input wire enc0_b,
    input wire enc1_a,
    input wire enc1_b,
    input wire enc2_a,
    input wire enc2_b,
    output wire pwm0_out,
    output wire pwm1_out,
    output wire pwm2_out
);

    wire [7:0] enc [2:0];

    wire enc_a [2:0];
    wire enc_b [2:0];

    assign enc_a[0] = enc0_a;
    assign enc_b[0] = enc0_b;
    assign enc_a[1] = enc1_a;
    assign enc_b[1] = enc1_b;
    assign enc_a[2] = enc2_a;
    assign enc_b[2] = enc2_b;

    wire enc_a_db [2:0];
    wire enc_b_db [2:0];
    wire pwm_out [2:0];

    assign pwm0_out = pwm_out[0];
    assign pwm1_out = pwm_out[1];
    assign pwm2_out = pwm_out[2];
    
    generate
    	genvar i;
    	for(i=0; i<3; i=i+1)begin
            debounce u1(.clk(clk), .reset(reset), .button(enc_a[i]), .debounced(enc_a_db[i]));
            debounce u2(.clk(clk), .reset(reset), .button(enc_b[i]), .debounced(enc_b_db[i]));
            encoder u3(.clk(clk), .reset(reset), .a(enc_a_db[i]), .b(enc_b_db[i]), .value(enc[i]));
            pwm u4(.clk(clk), .reset(reset), .out(pwm_out[i]), .level(enc[i]));
        end
   endgenerate
    
endmodule

