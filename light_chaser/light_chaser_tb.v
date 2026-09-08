`timescale 1ns/1ps

module light_chaser_tb;

    parameter REG_WIDTH    = 10;
    parameter CLK_IN_FREQ  = 32;
    parameter CLK_OUT_FREQ = 8;

    reg                     clk_50m;   // clk INPUT, before division
    reg                     reset_n;
    reg                     hold_n;
    wire [REG_WIDTH-1:0]    shift_out;

    // Hierarchical probe of the internal divided clock (clk_8hz),
    // i.e. clk AFTER division and BEFORE it drives the shift register.
    wire clk_div_probe = dut.clk_8hz;

    // Instantiate DUT (top-level module)
    light_chaser_top #(
        .CLK_IN_FREQ  (CLK_IN_FREQ),
        .CLK_OUT_FREQ (CLK_OUT_FREQ),
        .REG_WIDTH    (REG_WIDTH)
    ) 
    
    dut (
        .clk_50m   (clk_50m),
        .reset_n   (reset_n),
        .hold_n    (hold_n),
        .shift_out (shift_out)
    );

    // Input clock generation
    initial clk_50m = 0;
    always #10 clk_50m = ~clk_50m;   // 100ns period "clk_50m" (scaled)

    initial begin

        reset_n = 1;
        hold_n  = 1;

        reset_n = 0;
        #20;
        reset_n = 1;

        // Let it shift freely for a while
        repeat (60) @(posedge clk_50m);

        // Test hold
        hold_n = 0;             // assert hold (active low)
        repeat (20) @(posedge clk_50m);
        hold_n = 1;             // release hold, resume shifting

        repeat (60) @(posedge clk_50m);

        // Test reset mid-shift (async)
        #13 reset_n = 0;
        #27 reset_n = 1;

        repeat (40) @(posedge clk_50m);

        $finish;
    end

    initial begin
        $monitor("t=%0t clk_50m=%b clk_8hz=%b reset_n=%b hold_n=%b shift_out=%b",
                  $time, clk_50m, clk_div_probe, reset_n, hold_n, shift_out);
    end

endmodule
