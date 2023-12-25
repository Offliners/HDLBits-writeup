module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    parameter IDLE=0, START=1, CHECK=2, STOP=3, ERROR=4;
    reg [2:0] state, next_state;
    reg [3:0] count;
    reg [8:0] data;
    reg odd_reset;
    reg odd_reg;
    wire odd;

    // Modify FSM and datapath from Fsm_serialdata
    always @(*) begin
        case(state)
            IDLE : next_state <= in ? IDLE : START;
            START : next_state <= count == 8 ? CHECK : START;
            CHECK : next_state <= in ? STOP : ERROR;
            STOP : next_state <= in ? IDLE : START;
            ERROR : next_state <= in ? IDLE : ERROR;
			default: next_state <= IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
            count <= 4'b0;
            odd_reg <= 1'b0;
        end
        else begin
            if(state == START && count != 8) begin
                count <= count + 4'b1;
                data <= {in, data[7:1]};
            end
            else if(state == STOP || state == ERROR)
                count <= 4'b0;
            else
                count <= count;
            
            state <= next_state;
            odd_reg <= odd;
        end
    end
    
    always @(posedge clk) begin
        case(next_state)
            IDLE : odd_reset <= 1'b1;
            STOP : odd_reset <= 1'b1;
            default: odd_reset <= 1'b0;
        endcase
    end

    // New: Add parity checking.
    assign done = (state == STOP) && odd_reg;
    assign out_byte = done ? data : 8'b0;
    parity P(.clk(clk), .reset(reset | odd_reset), .in(in), .odd(odd));

endmodule