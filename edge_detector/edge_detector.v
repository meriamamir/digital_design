module edge_detector (
    input  wire clk,
    input  wire rst_n,
    input  wire IN,
    output wire Rise_Tick,
    output wire Fall_Tick,
    output wire Edge_Tick
);

    localparam S_LOW  = 2'b00;
    localparam S_RISE = 2'b01;
    localparam S_HIGH = 2'b10;
    localparam S_FALL = 2'b11;

    reg [1:0] current_state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) current_state <= S_LOW;
        else        current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            S_LOW  : next_state = IN ? S_RISE : S_LOW;
            S_RISE : next_state = S_HIGH;                
            S_HIGH : next_state = IN ? S_HIGH : S_FALL;
            S_FALL : next_state = S_LOW;                 
            default: next_state = S_LOW;
        endcase
    end

    assign Rise_Tick = (current_state == S_RISE);
    assign Fall_Tick = (current_state == S_FALL);
    assign Edge_Tick = Rise_Tick | Fall_Tick;

endmodule