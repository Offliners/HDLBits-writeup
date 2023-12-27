module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    reg [3:0] temp;
    
    always @(posedge clk) begin
        if(shift_ena)
            temp <= {temp[2:0], data};
        else if(count_ena)
            temp <= temp - 4'b1;
        else
            temp <= temp;
    end
    
    assign q = temp;

endmodule