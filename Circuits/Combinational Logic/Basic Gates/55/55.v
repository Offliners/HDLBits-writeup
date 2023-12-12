module top_module (input x, input y, output reg z);
    reg out_IA1, out_IB1, out_IA2, out_IB2;
    
    task A;
        input x, y;
        output z;
        begin
            z = (x ^ y) & x;
        end
    endtask
    
    task B;
        input x, y;
        output z;
        begin
            if(x == y)
                z = 1'b1;
            else
                z = 1'b0;
        end
    endtask
    
    always @(*) begin
        A(x, y, out_IA1);
        B(x, y, out_IB1);
        A(x, y, out_IA2);
        B(x, y, out_IB2);
        
        z = (out_IA1 | out_IB1) ^ (out_IA2 & out_IB2);
    end
    
endmodule
