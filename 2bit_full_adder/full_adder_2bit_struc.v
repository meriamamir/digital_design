module two_bit_full_adder_struc(
    input  wire a0, a1,
    input  wire b0, b1,
    input  wire cin,
    output wire sum0, sum1,
    output wire cout
);

    wire c1;

    one_bit_full_adder fa0 (
        .a    (a0),
        .b    (b0),
        .cin  (cin),
        .sum  (sum0),
        .cout (c1)
    );

    one_bit_full_adder fa1 (
        .a    (a1),
        .b    (b1),
        .cin  (c1),
        .sum  (sum1),
        .cout (cout)
    );

endmodule