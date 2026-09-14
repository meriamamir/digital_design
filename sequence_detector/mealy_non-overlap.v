module mealy_nonoverlap (
    input  wire clk,
    input  wire rst,
    input  wire din,
    output reg  dout
);
    localparam S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4, S5=3'd5;
    reg [2:0] state, next_state;
 
    always @(posedge clk) begin
        if (rst) state <= S0;
        else     state <= next_state;
    end
 
    always @(*) begin
        next_state = S0;
        dout       = 1'b0;
        case (state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S2 : S0;
            S2: next_state = din ? S2 : S3;
            S3: next_state = din ? S4 : S0;
            S4: next_state = din ? S2 : S5;
            S5: begin
                next_state = din ? S0 : S0; // always reset
                dout       = din;           // output 1 only when din completes match
            end
            default: next_state = S0;
        endcase
    end
endmodule