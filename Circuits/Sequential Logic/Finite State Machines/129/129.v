module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT_GND=2'b00, RIGHT_GND=2'b01, LEFT_AAAH=2'b10, RIGHT_AAAH=2'b11;
    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if(areset) 
            state <= LEFT_GND;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            LEFT_GND : next_state <= ground ? (bump_left ? RIGHT_GND : LEFT_GND) : LEFT_AAAH;
            RIGHT_GND : next_state <= ground ? (bump_right ? LEFT_GND : RIGHT_GND) : RIGHT_AAAH;
            LEFT_AAAH : next_state <= ground ? LEFT_GND : LEFT_AAAH;
            RIGHT_AAAH : next_state <= ground ? RIGHT_GND : RIGHT_AAAH;
            default: next_state <= LEFT_GND;
        endcase
    end
    
    assign walk_left = (state == LEFT_GND) ? 1'b1 : 1'b0;
    assign walk_right = (state == RIGHT_GND) ? 1'b1 : 1'b0;
    assign aaah = (state == LEFT_AAAH || state == RIGHT_AAAH) ? 1'b1 : 1'b0;

endmodule
