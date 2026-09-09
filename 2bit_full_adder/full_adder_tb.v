module two_bit_full_adder_tb;

  reg a0_tb, a1_tb;
  reg b0_tb, b1_tb;
  reg cin_tb;

  wire sum0_gate_tb, sum1_gate_tb, cout_gate_tb;
  wire sum0_struc_tb, sum1_struc_tb, cout_struc_tb;
  wire sum0_behav_tb, sum1_behav_tb, cout_behav_tb;

  two_bit_full_adder_gate dut_gate(
    .a0(a0_tb), .a1(a1_tb),
    .b0(b0_tb), .b1(b1_tb),
    .cin(cin_tb),
    .sum0(sum0_gate_tb), .sum1(sum1_gate_tb),
    .cout(cout_gate_tb)
  );

  two_bit_full_adder_struc dut_struc(
    .a0(a0_tb), .a1(a1_tb),
    .b0(b0_tb), .b1(b1_tb),
    .cin(cin_tb),
    .sum0(sum0_struc_tb), .sum1(sum1_struc_tb),
    .cout(cout_struc_tb)
  );

  two_bit_full_adder_behav dut_behav(
    .a0(a0_tb), .a1(a1_tb),
    .b0(b0_tb), .b1(b1_tb),
    .cin(cin_tb),
    .sum0(sum0_behav_tb), .sum1(sum1_behav_tb),
    .cout(cout_behav_tb)
  );

  integer i;

initial begin
    $monitor("t=%0t a1a0=%b%b b1b0=%b%b cin=%b || gate: sum1sum0=%b%b cout=%b || struc: sum1sum0=%b%b cout=%b || behav: sum1sum0=%b%b cout=%b",
              $time, a1_tb, a0_tb, b1_tb, b0_tb, cin_tb,
              sum1_gate_tb, sum0_gate_tb, cout_gate_tb,
              sum1_struc_tb, sum0_struc_tb, cout_struc_tb,
              sum1_behav_tb, sum0_behav_tb, cout_behav_tb);

    for (i = 0; i < 32; i = i + 1) begin
      {a1_tb, a0_tb, b1_tb, b0_tb, cin_tb} = i[4:0];
      #10;
    end
    $finish;
  end

endmodule