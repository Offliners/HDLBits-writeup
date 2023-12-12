module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output reg f   // one output
);
    wire [2:0] X;
    
    assign X = {x3, x2, x1};
    always @(*) begin
        case(X)
            2, 3, 5, 7 : f = 1'b1;
            default: f = 1'b0;
        endcase
    end

endmodule