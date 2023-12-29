module top_module ();
    reg clk, t, reset, q;

    initial begin
        clk <= 1'b0;
        reset <= 1'b0;
        t <= 1'b0;
        
        #10 reset <= 1'b1;
        #10 reset <= 1'b0;
        #10 t <= 1'b1;
    end
    
    always begin
       #5 clk = ~clk; 
    end
    
    tff TFF(.clk(clk), .reset(reset), .t(t), .q(q));
    
endmodule
