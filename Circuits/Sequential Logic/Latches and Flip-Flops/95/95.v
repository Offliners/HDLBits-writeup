module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    reg [7:0] in_state;
    
    always @(posedge clk) begin
        in_state <= in;
        pedge <= in & ~in_state;
    end

endmodule