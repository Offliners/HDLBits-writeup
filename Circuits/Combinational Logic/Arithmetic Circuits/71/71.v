module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    wire [99:0] carry;
    
    genvar i;
    generate 
        assign carry[0] = a[0] & b[0] | a[0] & cin | b[0] & cin;
        assign sum[0]  = a[0] ^ b[0] ^ cin;
        
        for(i = 1; i < 100; i = i + 1) begin : forloop
            assign carry[i] = a[i] & b[i] | a[i] & carry[i - 1] | b[i] & carry[i - 1];
            assign sum[i]  = a[i] ^ b[i] ^ carry[i - 1];
        end 
        
        assign cout = carry[99];
    endgenerate

endmodule