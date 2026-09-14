module debounce_tick_gen #(
    parameter DVSR = 9
) (
    input  wire clk,
    input  wire reset,
    output reg  m_tick
);
    reg [$clog2(DVSR+1)-1:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count  <= 0;
            m_tick <= 1'b0;
        end else if (count == DVSR) begin
            count  <= 0;
            m_tick <= 1'b1;
        end else begin
            count  <= count + 1;
            m_tick <= 1'b0;
        end
    end
endmodule