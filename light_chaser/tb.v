`timescale 1ns/1ps

module tb_light_chaser;
    parameter WIDTH        = 10;
    parameter CLK_IN_FREQ  = 50_000_000;
    parameter CLK_OUT_FREQ = 8;
    localparam DIVISOR = CLK_IN_FREQ / CLK_OUT_FREQ;

    wire  clk_out;
    reg   clk_in;
    reg   reset_n;
    reg   hold_n;
    wire [WIDTH-1:0] shift_out;

light_chaser #(
    .CLK_IN_FREQ  (CLK_IN_FREQ),
    .CLK_OUT_FREQ (CLK_OUT_FREQ),
    .WIDTH        (WIDTH)
    ) dut (
        .clk_in    (clk_in),
        .clk_out    (clk_out),
        .reset_n    (reset_n),
        .hold_n     (hold_n),
        .shift_out  (shift_out)
    );


    initial clk_in = 0;
    always #10 clk_in = ~clk_in;   // 20 ns period -> 50 MHz

    initial begin
        reset_n = 1;
        hold_n  = 1;

        reset_n = 0;
        #12;
        reset_n = 1;

        // Free-run for 11 clk_out periods -> full 10-bit wraparound + 1 extra
        repeat (11 * DIVISOR) @(posedge clk_in);

        // Hold for 3 clk_out periods
        hold_n = 0;
        repeat (3 * DIVISOR) @(posedge clk_in);
        hold_n = 1;

        // Resume, run 4 more clk_out periods
        repeat (4 * DIVISOR) @(posedge clk_in);

        // Async reset mid-shift
        #3 reset_n = 0;
        #7 reset_n = 1;

        // Run 4 more clk_out periods after reset
        repeat (4 * DIVISOR) @(posedge clk_in);

        $finish;
    end

    initial begin
        $monitor("t=%0t reset_n=%b hold_n=%b shift_out=%b",
                  $time, reset_n, hold_n, shift_out);
    end

endmodule