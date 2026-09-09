module two_bit_full_adder_behav(
    input  wire a0, a1,
    input  wire b0, b1,
    input  wire cin,
    output wire sum0, sum1,
    output wire cout
);

    assign {cout, sum1, sum0} = {a1, a0} + {b1, b0} + cin;

endmodule