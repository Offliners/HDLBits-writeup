module top_module ( );
    parameter time_period = 10;
    reg clk;
    initial clk = 0;
    
    always begin
        #(time_period / 2) clk = ~clk;
    end
    
    dut DUT0(.clk(clk));
    
endmodule
