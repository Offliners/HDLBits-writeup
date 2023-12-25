module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    parameter IDLE=0, S0=1, S1=2, S2=3;
    reg [1:0] state, next_state;
    reg [23:0] data;
    
    // FSM from fsm_ps2
    always @(*) begin
        case(state)
            IDLE : next_state <= in[3] ? S0 : IDLE;
            S0 : next_state <= S1;
            S1 : next_state <= S2;
            S2 : next_state <= in[3] ? S0 : IDLE;
            default: next_state <= IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
            data <= 24'b0;
        end
        else begin
            state <= next_state;
            data <= {data[15:0], in};
        end
    end

    // New: Datapath to store incoming bytes.
    assign done = state == S2;
    assign out_bytes = done ? data : 24'b0;

endmodule