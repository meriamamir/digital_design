module binary_to_gray(
    input  wire [3:0] bin_in,
    output wire [3:0] gray_out
);

    assign gray_out[3] = bin_in[3];

    genvar i;
    generate
        for (i = 2; i >= 0; i = i - 1) begin
            assign gray_out[i] = bin_in[i+1] ^ bin_in[i];
        end
    endgenerate

endmodule