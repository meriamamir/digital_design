module one_bit_full_adder(
    input  wire a, b, cin,
    output wire sum, cout
);

    wire ab_xor, ab_and, cin_and;

    xor g1 (ab_xor, a, b);
    xor g2 (sum, ab_xor, cin);

    and g3 (ab_and, a, b);
    and g4 (cin_and, ab_xor, cin);
    or  g5 (cout, ab_and, cin_and);

endmodule
