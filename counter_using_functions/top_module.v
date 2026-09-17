module counter #(
  parameter WIDTH = 5
)(
  input  wire             clk,
  input  wire             rst,
  input  wire             load,
  input  wire             enab,
  input  wire [WIDTH-1:0] cnt_in,
  output reg  [WIDTH-1:0] cnt_out
);

  function [WIDTH-1:0] next_count;
    input             rst;
    input             load;
    input             enab;
    input [WIDTH-1:0] cnt_in;
    input [WIDTH-1:0] cnt_out;
    begin
      if (rst)
        next_count = {WIDTH{1'b0}};
      else if (load)
        next_count = cnt_in;
      else if (enab)
        next_count = cnt_out + 1'b1;
      else
        next_count = cnt_out;
    end
  endfunction

  // calls the function
  always @(posedge clk) begin
    cnt_out <= next_count(rst, load, enab, cnt_in, cnt_out);
  end

endmodule