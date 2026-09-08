module shift_reg #(
    parameter WIDTH = 10
) (
    input  wire clk,
    input  wire reset_n,  
    input  wire hold_n,   
    output wire [WIDTH-1:0]  shift_out
);

    reg [WIDTH-1:0] shift_reg;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            shift_reg <= {1'b1, {(WIDTH-1){1'b0}}};  
        end
        else if (hold_n) begin
            shift_reg <= {shift_reg[0], shift_reg[WIDTH-1:1]};  
        end
    end

    assign shift_out = shift_reg;

endmodule