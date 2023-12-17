module top_module (
    input clk,
    input d,
    output q
);
    reg q_pos, q_neg;
    
    always @(posedge clk) begin
        q_pos <= d;
    end
    
    always @(negedge clk) begin
        q_neg <= d;
    end
    
    assign q = clk ? q_pos : q_neg;

endmodule
