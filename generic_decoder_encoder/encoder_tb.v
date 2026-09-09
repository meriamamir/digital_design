module encoder_generic_tb;

    reg  [3:0] in_tb;
    reg  en_tb;
    wire [1:0] out_tb;

    encoder_generic #(.N(2)) dut (
        .in(in_tb),
        .en(en_tb),
        .out(out_tb)
    );

    initial begin
       $monitor("t=%0t en=%b in=%b out=%b", $time, en_tb, in_tb, out_tb);

        en_tb = 1; in_tb = 4'b0001; #10;
        en_tb = 1; in_tb = 4'b0010; #10;
        en_tb = 1; in_tb = 4'b0100; #10;
        en_tb = 1; in_tb = 4'b1000; #10;
        en_tb = 0; in_tb = 4'b1111; #10;

        $finish;
    end

endmodule