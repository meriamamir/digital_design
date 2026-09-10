`timescale 1ns/1ps

module tb_edge_detector;

    reg  clk;
    reg  rst;
    reg  level;

    wire tick_mealy;
    wire tick_moore;

    mealy_edge_detector u_mealy (
        .clk   (clk),
        .rst   (rst),
        .level (level),
        .tick  (tick_mealy)
    );

    moore_edge_detector u_moore (
        .clk   (clk),
        .rst   (rst),
        .level (level),
        .tick  (tick_moore)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("edge_detector.vcd");
        $dumpvars(0, tb_edge_detector);
    end

    initial begin
        $monitor("t=%0t | rst=%b level=%b | mealy_tick=%b | moore_tick=%b",
                   $time, rst, level, tick_mealy, tick_moore);
    end

    initial begin
        rst   = 1;
        level = 0;
        repeat (2) @(posedge clk);
        rst = 0;

        repeat (3) @(posedge clk);

        level = 1;
        repeat (4) @(posedge clk);

        level = 0;
        repeat (4) @(posedge clk);

        $display("Simulation complete.");
        $finish;
    end

endmodule