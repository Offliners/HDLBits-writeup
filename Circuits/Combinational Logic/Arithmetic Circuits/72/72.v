module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [3:0] carry;
    
    genvar i;
    generate
        bcd_fadd BCD_FADD(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(carry[0]), .sum(sum[3:0]));
        
        for(i = 4; i < 16; i = i + 4) begin : forloop
            bcd_fadd BCD_FADD(.a(a[i + 3 : i]), .b(b[i + 3 : i]), .cin(carry[i / 4 - 1]), .cout(carry[i / 4]), .sum(sum[i + 3 : i]));
        end
        
        assign cout = carry[3];
    endgenerate

endmodule