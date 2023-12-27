module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=1'b0, B=1'b1;
    reg state, next_state;
    reg [1:0] count;
    reg [2:0] w_record;
    
    always @(posedge clk) begin
        if(reset) begin
            state <= A;
            count <= 2'b0;
            w_record <= 3'b0;
        end
        else begin
            if(state == B) begin
                if(count == 2'd3)
                    count <= 2'b1;
                else
                	count <= count + 2'b1;
                
                w_record <= {w_record[1:0], w};
            end
            else begin
                count <= count;
                w_record <= w_record;
            end
            
            state <= next_state;
        end
    end
    
    always @(*) begin
        case(state)
            A : next_state <= s ? B : A;
            B : next_state <= B;
            default: next_state <= A;
        endcase
    end
    
    assign z = (count == 2'b11) && (w_record == 3'b011 || w_record == 3'b101 || w_record == 3'b110);

endmodule