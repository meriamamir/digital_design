module counter #(
  parameter WIDTH = 5
)(
  input  wire                clk,
  input  wire                wr,
  input  wire                rst,
  input  wire               enab,
  input  wire               load,
  input  wire [WIDTH-1:0]   cnt_in,
  output reg [WIDTH-1:0]   cnt_out
);

  reg [WIDTH-1:0] next_cnt;

  // Combinational
  always @(*) begin
    if (rst)
      next_cnt = {WIDTH{1'b0}};
    else if (load)
      next_cnt = cnt_in;
    else if (enab)
      next_cnt = cnt_out + 1'b1;
    else
      next_cnt = cnt_out;
  end

  // Sequential
  always @(posedge clk) begin
    cnt_out <= next_cnt;
  end


endmodule
