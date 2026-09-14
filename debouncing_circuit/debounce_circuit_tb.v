`timescale 1ns/1ps

module debounce_tb;
    reg clk, reset, sw;
    wire m_tick, debounced_out;

    debounce_tick_gen #(.DVSR(9)) tick_gen (
        .clk(clk),
        .reset(reset),
        .m_tick(m_tick)
    );

    debounce_fsm fsm (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .m_tick(m_tick),
        .debounced_out (debounced_out )
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        sw    = 0;
        #20 reset = 0;

        // ---- Simulate a bouncy switch going from 0 -> 1 ----
        #100 sw = 1;      // first bounce edge
        #20  sw = 0;      // glitch
        #15  sw = 1;      // glitch
        #10  sw = 0;      // glitch
        #30  sw = 1;      // settles high

        #500;             // hold stable well past 3 ticks (300 ns)

        // ---- Simulate a bouncy switch going from 1 -> 0 ----
        sw = 0;
        #20 sw = 1;
        #15 sw = 0;
        #10 sw = 1;
        #500;

        $finish;
    end

    initial
        $monitor("time=%0t sw=%b m_tick=%b debounced_out=%b state=%0d",
                  $time, sw, m_tick, debounced_out, fsm.state_reg);

endmodule