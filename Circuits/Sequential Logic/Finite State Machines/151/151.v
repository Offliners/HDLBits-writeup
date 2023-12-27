module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A=4'd0, B=4'd1, C=4'd2, D=4'd3, E=4'd4, F=4'd5, G=4'd6, H=4'd7, I=4'd8, J=4'd9;
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if(~resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A : next_state <= B;
            B : next_state <= C;
            C : next_state <= x ? D : C;
            D : next_state <= x ? D : E;
            E : next_state <= x ? F : C;
            F : next_state <= y ? G : H;
            G : next_state <= G;
            H : next_state <= y ? J : I;
            I : next_state <= I;
            J : next_state <= J;
            default: next_state <= A;
        endcase
    end
    
    assign f = state == B;
    assign g = state == F || state == G || state == H || state == J;

endmodule