module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    Mux_DFF mux_dff_1(.clk(KEY[0]), .in_0(LEDR[2]), .in_1(SW[0]), .L(KEY[1]), .q(LEDR[0]));
    Mux_DFF mux_dff_2(.clk(KEY[0]), .in_0(LEDR[0]), .in_1(SW[1]), .L(KEY[1]), .q(LEDR[1]));
    Mux_DFF mux_dff_3(.clk(KEY[0]), .in_0(LEDR[1] ^ LEDR[2]), .in_1(SW[2]), .L(KEY[1]), .q(LEDR[2]));

endmodule

module Mux_DFF(
    input clk,
    input in_0,
    input in_1,
    input L,
    output reg q
);
    always @(posedge clk) begin
        q <= L ? in_1 : in_0;
    end
    
endmodule