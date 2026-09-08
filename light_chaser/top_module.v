module light_chaser #(
    parameter CLK_IN_FREQ  = 50_000_000,
    parameter CLK_OUT_FREQ = 8,
    parameter WIDTH    = 10,
    localparam DIVISOR = CLK_IN_FREQ / CLK_OUT_FREQ
) (
    input  wire  clk_in,
    input  wire  reset_n,    
    input  wire  hold_n,     
    output wire  clk_out,  
    output wire [WIDTH-1:0]  shift_out
);


    clk_divider #(
        .DIVISOR (CLK_IN_FREQ / CLK_OUT_FREQ)
    ) u_clk_divider (
        .clk_in  (clk_in),
        .reset_n  (reset_n),
        .clk_out  (clk_out)
    );

    shift_reg #(
        .WIDTH (WIDTH)
    ) u_shift_reg (
        .clk        (clk_out),
        .reset_n    (reset_n),
        .hold_n     (hold_n),
        .shift_out  (shift_out)
    );

endmodule