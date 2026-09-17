module memory_test;

  localparam integer AWIDTH=5;
  localparam integer DWIDTH=8;

  reg               clk   ;
  reg               wr    ;
  reg               rd    ;
  reg  [AWIDTH-1:0] addr  ;
  wire [DWIDTH-1:0] data  ;
  reg  [DWIDTH-1:0] rdata ;

  assign data = rdata;

  memory #(
    .AWIDTH ( AWIDTH ),
    .DWIDTH ( DWIDTH )
   ) memory_inst (
    .clk  ( clk  ),
    .wr   ( wr   ),
    .rd   ( rd   ),
    .addr ( addr ),
    .data ( data )
   );

  task expect;
    input [DWIDTH-1:0] exp_data;
    if (data !== exp_data) begin
      $display("TEST FAILED");
      $display("At time %0d addr=%b data=%b", $time, addr, data);
      $display("data should be %b", exp_data);
      $finish;
    end
    else begin
      $display("At time %0d addr=%b data=%b", $time, addr, data);
    end
  endtask

  task mem_write;
    input [AWIDTH-1:0] a;
    input [DWIDTH-1:0] d;
    begin
      wr    = 1;
      rd    = 0;
      addr  = a;
      rdata = d;
      @(negedge clk);
    end
  endtask

  task mem_read_check;
    input [AWIDTH-1:0] a;
    input [DWIDTH-1:0] d;
    begin
      wr    = 0;
      rd    = 1;
      addr  = a;
      rdata = 'bz;
      @(negedge clk) expect(d);
    end
  endtask

  initial repeat (67) begin #5 clk=1; #5 clk=0; end

  initial @(negedge clk) begin : TEST
    reg [AWIDTH-1:0] a;
    reg [DWIDTH-1:0] d;

    a = 0;  d = -1;  mem_write(a, d);
    a = -1; d = 0;   mem_write(a, d);

    a = 0;  d = -1;  mem_read_check(a, d);
    a = -1; d = 0;   mem_read_check(a, d);

    $display("Writing ascending data to   descending addresses");
    a = -1; d = 0;
    while (a) begin
      mem_write(a, d);
      a = a - 1;
      d = d + 1;
    end

    $display("Reading ascending data from descending addresses");
    a = -1; d = 0;
    while (a) begin
      mem_read_check(a, d);
      a = a - 1;
      d = d + 1;
    end

    $display("TEST PASSED");
    $finish;
  end

endmodule