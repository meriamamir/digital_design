`timescale 1ns / 1ps

module top_module_tb;

    reg clk_50M;
    reg rst_n;
    reg IN;

    wire clk_out;
    wire [6:0] R, R_c, F, F_c, t, t_c;

    top_module dut (
        .clk_50M(clk_50M),
        .rst_n(rst_n),
        .IN(IN),
        .clk_out(clk_out),
        .R(R), .R_c(R_c),
        .F(F), .F_c(F_c),
        .t(t), .t_c(t_c)
    );

    defparam dut.u_clk_div.DIVISOR = 10;

    always #10 clk_50M = ~clk_50M;

    initial begin
        clk_50M = 0;
        rst_n   = 0;
        IN      = 0;

        // Hold reset for 5 clock cycles using repeat
        repeat (5) @(posedge clk_50M);
        rst_n = 1; // Release reset

        // Wait 10 clock cycles before driving IN
        repeat (10) @(posedge clk_50M);

        // Generate 8 input pulses using a repeat loop
        repeat (8) begin
            IN = 1;
            repeat (20) @(posedge clk_50M); // Hold HIGH for 20 clock cycles
            IN = 0;
            repeat (20) @(posedge clk_50M); // Hold LOW for 20 clock cycles
        end

        $finish;
    end

endmodule