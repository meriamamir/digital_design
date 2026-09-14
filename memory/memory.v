module memory  #(
 parameter AWIDTH = 5,
 parameter DWIDTH = 8
)(
   input wire clk,
   input wire wr,
   input wire rd,
   input wire [AWIDTH-1:0] addr,
   inout reg [DWIDTH-1:0] data
);  
   reg [DWIDTH-1:0] mem [0:(1<<AWIDTH)-1];
   reg [DWIDTH-1:0] data_out_reg;

  // Synchronous write
  always @(posedge clk) begin
    if (wr)
      mem[addr] <= data;
  end

  // Asynchronous read
  always @(*) begin
    if (rd)
      data_out_reg = mem[addr];
    else
      data_out_reg = {DWIDTH{1'bz}};
  end

  assign data = (rd) ? data_out_reg : {DWIDTH{1'bz}};
  

endmodule
