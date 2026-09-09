module decoder_generic #(
    parameter N = 2                  
)(
    input  wire [N-1:0]in,     
    input  wire  en,     
    output reg  [(1<<N)-1:0] out     
);

    integer i;

    always @(*) begin
        if (en) begin
            out = {(1<<N){1'b0}};     
            out[in] = 1'b1;           
        end
        else begin
            out = {(1<<N){1'b0}}; 
        end
    end

endmodule