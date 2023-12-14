module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [3:0] carry;
    
    genvar i;
    generate
        assign {carry[0], sum[0]} = x[0] + y[0];
        for(i = 1; i < 4; i = i + 1) begin : forloop
            assign {carry[i], sum[i]} = x[i] + y[i] + carry[i - 1];
        end
        assign sum[4] = carry[3];
    endgenerate

endmodule