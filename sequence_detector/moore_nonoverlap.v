module moore_nonoverlap (
    input  wire clk,
    input  wire rst,
    input  wire din,
    output wire dout
);
    localparam S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4, S5=3'd5, S6=3'd6;
    reg [2:0] state, next_state;
 
    always @(posedge clk) begin
        if (rst) state <= S0;
        else     state <= next_state;
    end
 
    always @(*) begin
        case (state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S2 : S0;
            S2: next_state = din ? S2 : S3;
            S3: next_state = din ? S4 : S0;
            S4: next_state = din ? S2 : S5;
            S5: next_state = din ? S6 : S0;
            S6: next_state = din ? S1 : S0;   // behaves like S0 (no reuse)
            default: next_state = S0;
        endcase
    end
 
    assign dout = (state == S6);
endmodule
 