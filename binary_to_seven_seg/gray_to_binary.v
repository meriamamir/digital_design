
module gray_to_binary #(
    parameter GL = 4                  
)(
    input  wire [GL-1:0] gray_in,    
    output wire [GL-1:0] bin_out     
);

    genvar i;

    buf b_msb (bin_out[GL-1], gray_in[GL-1]);

    generate
        for (i = GL-2; i >= 0; i = i - 1) begin
            xor x_bit (bin_out[i], bin_out[i+1], gray_in[i]);
        end
    endgenerate

endmodule

