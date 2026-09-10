module moore_edge_detector (
    input  clk,
    input  rst,
    input  level,
    output tick
);

localparam ZERO = 2'b00;
localparam EDG  = 2'b01;
localparam ONE  = 2'b10;

reg [1:0] current_state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst) current_state <= ZERO;
        else     current_state <= next_state;
    end

    always @(*) begin                            
        case (current_state)
            ZERO: next_state = level ? EDG  : ZERO;
            EDG : next_state = ONE;
            ONE : next_state = level ? ONE  : ZERO;
            default: next_state = ZERO;
        endcase
    end                                            


    assign tick = (current_state == EDG);

endmodule