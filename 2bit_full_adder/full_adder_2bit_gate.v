module two_bit_full_adder_gate(
    input  wire a0, a1,
    input  wire b0, b1,
    input  wire cin,
    output wire sum0, sum1,
    output wire cout
);

    wire axorb0, ab0, cin_and_axorb0;   
    wire c1;                            
    wire axorb1, ab1, c1_and_axorb1;   

    xor g1 (axorb0, a0, b0);
    xor g2 (sum0, cin, axorb0);
    and g3 (ab0, a0, b0);
    and g4 (cin_and_axorb0, cin, axorb0);
    or  g5 (c1, cin_and_axorb0, ab0);
    xor g6 (axorb1, a1, b1);
    xor g7 (sum1, c1, axorb1);
    and g8 (ab1, a1, b1);
    and g9 (c1_and_axorb1, c1, axorb1);
    or  g10 (cout, c1_and_axorb1, ab1);

endmodule