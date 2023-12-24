module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter LEFT_GND=3'b000, RIGHT_GND=3'b001, LEFT_AAAH=3'b010, RIGHT_AAAH=3'b011, LEFT_DIG=3'b100, RIGHT_DIG=3'b101, SPLATTER=3'b110;
    reg [2:0] state, next_state;
    reg [31:0] aaah_cnt;
    
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= LEFT_GND;
        else if(state == LEFT_AAAH || state == RIGHT_AAAH) begin
            aaah_cnt <= aaah_cnt + 5'b1;
            state <= next_state;
        end
        else begin
            aaah_cnt <= 5'b0;
            state <= next_state;
        end
    end
    
    always @(*) begin
        case(state)
            LEFT_GND : next_state <= ground ? (dig ? LEFT_DIG : (bump_left ? RIGHT_GND : LEFT_GND)) : LEFT_AAAH;
            RIGHT_GND : next_state <= ground ? (dig ? RIGHT_DIG : (bump_right ? LEFT_GND : RIGHT_GND)) : RIGHT_AAAH;
            LEFT_AAAH : next_state <= ground ? (aaah_cnt > 5'd19 ? SPLATTER : LEFT_GND) : LEFT_AAAH;
            RIGHT_AAAH : next_state <= ground ? (aaah_cnt > 5'd19 ? SPLATTER : RIGHT_GND) : RIGHT_AAAH;
            LEFT_DIG : next_state <= ground ? LEFT_DIG : LEFT_AAAH;
            RIGHT_DIG : next_state <= ground ? RIGHT_DIG : RIGHT_AAAH;
            SPLATTER : next_state <= SPLATTER;
            default: next_state <= LEFT_GND;
        endcase
    end
    
    assign walk_left = (state == LEFT_GND) ? 1'b1 : 1'b0;
    assign walk_right = (state == RIGHT_GND) ? 1'b1 : 1'b0;
    assign aaah = (state == LEFT_AAAH || state == RIGHT_AAAH) ? 1'b1 : 1'b0;
    assign digging = (state == LEFT_DIG || state == RIGHT_DIG) ? 1'b1 : 1'b0;

endmodule