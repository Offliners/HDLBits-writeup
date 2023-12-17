module top_module (
    input clk,
    input reset,
    input enable,
    output reg [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    
    always @(posedge clk) begin
        if(reset || (enable && Q == 4'd12))
            Q <= 4'd1;
        else if(enable)
            Q <= Q + 4'd1;
        else
            Q <= Q;
    end
    
    assign c_enable = enable;
    assign c_load = reset || (enable && Q == 4'd12);
    assign c_d = c_load ? 4'd1 : 4'd0;

    count4 the_counter (clk, c_enable, c_load, c_d /*, ... */ );

endmodule
