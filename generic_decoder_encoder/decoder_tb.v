module decoder_generic_tb;

    reg  [1:0] in_tb;
    reg  en_tb;
    wire [3:0] out_tb;

    decoder_generic #(.N(2)) dut (
        .in(in_tb),
        .en(en_tb),
        .out(out_tb)
    );

    initial begin   
    $monitor("t=%0t en=%b in=%b out=%b", $time, en_tb, in_tb, out_tb);


        en_tb = 1; in_tb = 2'b00; #10;   // expect = 0001
        en_tb = 1; in_tb = 2'b01; #10;   // expect = 0010
        en_tb = 1; in_tb = 2'b10; #10;   // expect = 0100
        en_tb = 1; in_tb = 2'b11; #10;   // expect = 1000
        en_tb = 0; in_tb = 2'b11; #10;   // expect = 0000

        $finish;
    end

endmodule