module sequence_detectors_tb;
    reg clk = 0;
    reg rst = 1;
    reg din = 0;
    wire d_mo, d_mn, d_oo, d_on;
 
    mealy_overlap    u_mo (.clk(clk), .rst(rst), .din(din), .dout(d_mo));
    mealy_nonoverlap u_mn (.clk(clk), .rst(rst), .din(din), .dout(d_mn));
    moore_overlap    u_oo (.clk(clk), .rst(rst), .din(din), .dout(d_oo));
    moore_nonoverlap u_on (.clk(clk), .rst(rst), .din(din), .dout(d_on));
 
    always #5 clk = ~clk;
 
    // Bit stream: 110101 101010 1  (overlap should refire, non-overlap once)
    reg [0:14] stream = 15'b1_1_0_1_0_1_1_0_1_0_1_0_1_0_0;
    integer i;
    reg m_ov, m_no; // latched Mealy outputs (combinational, sampled pre-edge)
 
    initial begin
        $display(" t  bit  MealyOv MealyNo MooreOv MooreNo");
        @(negedge clk); rst = 0;
        for (i = 0; i < 15; i = i + 1) begin
            din = stream[i];
            #1;                    // Mealy output reacts instantly: old state + new din
            m_ov = d_mo;
            m_no = d_mn;
            @(posedge clk);        // flops update: state advances using this din
            #1;                    // Moore output reflects the new state
            $display("%2d   %b     %b       %b       %b       %b",
                      i, din, m_ov, m_no, d_oo, d_on);
        end
        $finish;
    end
endmodule