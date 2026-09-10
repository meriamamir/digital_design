module top_module (
    input  wire clk_50M,
    input  wire rst_n,
    input  wire IN,
    output wire clk_out,
    output wire [6:0] R,
    output wire [6:0] R_c,
    output wire [6:0] F,
    output wire [6:0] F_c,
    output wire [6:0] t,
    output wire [6:0] t_c
);

    wire clk_100Hz;
    wire rise_tick_w, fall_tick_w, edge_tick_w;
    wire [3:0] rise_count_w, fall_count_w, edge_count_w;

    assign clk_out = clk_100Hz;

    clk_div #(
        .DIVISOR(500_000)
    ) u_clk_div (
        .clk_in(clk_50M),
        .rst_n(rst_n),
        .clk_out(clk_100Hz)
    );

    edge_detector u_edge_detector (
        .clk(clk_100Hz),
        .rst_n(rst_n),
        .IN(IN),
        .Rise_Tick(rise_tick_w),
        .Fall_Tick(fall_tick_w),
        .Edge_Tick(edge_tick_w)
    );

    edge_counter u_edge_counter (
        .clk(clk_100Hz),
        .rst_n(rst_n),
        .Rise_Tick(rise_tick_w),
        .Fall_Tick(fall_tick_w),
        .Edge_Tick(edge_tick_w),
        .Rise_Count(rise_count_w),
        .Fall_Count(fall_count_w),
        .Edge_Count(edge_count_w)
    );

    six_seven_seg u_six_seven_seg (
        .rst_n(rst_n),
        .Rise_Count(rise_count_w),
        .Fall_Count(fall_count_w),
        .Edge_Count(edge_count_w),
        .R(R),
        .R_c(R_c),
        .F(F),
        .F_c(F_c),
        .t(t),
        .t_c(t_c)
    );

endmodule