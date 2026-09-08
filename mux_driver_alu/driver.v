module driver #(
parameter WIDTH= 8
)(
input wire [WIDTH-1:0] data_in,
output wire [WIDTH-1:0] data_out,
input wire data_en
);

 assign data_out = data_en ? data_in : {WIDTH{1'bz}};

endmodule