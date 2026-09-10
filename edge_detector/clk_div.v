module clk_div #(
    parameter DIVISOR = 500_000   
) (
    input  wire clk_in,
    input  wire rst_n,  
    output reg  clk_out
);

    localparam CNT_WIDTH = $clog2(DIVISOR);
    reg [CNT_WIDTH-1:0] count;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            count   <= 0;
            clk_out <= 1'b0;
        end
        else if (count == (DIVISOR/2 - 1)) begin
            count   <= 0;
            clk_out <= ~clk_out; 
        end
        else begin
            count <= count + 1'b1;
        end
    end

endmodule