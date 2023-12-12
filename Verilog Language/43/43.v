module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [99:0] carry;
    bcd_fadd BCD_FADD(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(carry[0]), .sum(sum[3:0]));
    
    genvar i;
    generate 
        for(i = 4; i < 400; i = i + 4) begin : forloop
            bcd_fadd BCD_FADD(.a(a[i+3:i]), .b(b[i+3:i]), .cin(carry[i/4-1]), .cout(carry[i/4]), .sum(sum[i+3:i]));
        end 
        
        assign cout = carry[99];
    endgenerate

endmodule