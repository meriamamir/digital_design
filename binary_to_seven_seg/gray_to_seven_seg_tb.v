`timescale 1ns/1ps

module gray_to_seven_seg_tb;

    reg  [3:0] Gray_in;
    wire [6:0] Seg_out;
    wire [3:0] Bin_out;     

    gray_to_seven_seg DUT (
        .Gray_in (Gray_in),
        .Seg_out (Seg_out)
    );

    assign Bin_out = DUT.Bin_out; 

    integer i;

    initial begin
        $display("Gray_in  Bin_out  Seg_out");

        for (i = 0; i < 16; i = i + 1) begin
            Gray_in = i;
            #10;
            $display("%b\t %b\t %b", Gray_in, Bin_out, Seg_out);
        end

        $finish;
    end

endmodule