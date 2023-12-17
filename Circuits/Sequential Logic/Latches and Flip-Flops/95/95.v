module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    reg [7:0] in_temp;
    
    always @(posedge clk) begin
        in_temp <= in;
        
        for(integer i = 0; i < 8; i = i + 1) begin
            if((in_temp[i] == 0) && (in[i] == 1))
                pedge[i] <= 1'b1;
            else
                pedge[i] <= 1'b0;
        end
    end

endmodule
