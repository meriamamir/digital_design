module gray_to_seven_seg #(
    parameter GL = 4
)(
    input  wire [GL-1:0] Gray_in,
    output wire [6:0]    Seg_out
);

    wire [GL-1:0] Bin_out;

    gray_to_binary #(.GL(GL)) gray2binary (
        .gray_in (Gray_in),
        .bin_out (Bin_out)
    );

    binary_to_seven_seg binary2sevenseg (
        .bin_in  (Bin_out),
        .seg_out (Seg_out)
    );

endmodule