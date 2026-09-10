module mealy_edge_detector (
    input  clk,
    input  rst,
    input  level,
    output tick
);

localparam ZERO = 1'b0;
localparam ONE  = 1'b1;

reg current_state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst) current_state <= ZERO;
        else     current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            ZERO: next_state = level ? ONE : ZERO;
            ONE : next_state = level ? ONE : ZERO;
            default: next_state = ZERO;
        endcase
    end

    assign tick = (current_state == ZERO) && level;

endmodule