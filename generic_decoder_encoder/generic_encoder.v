module encoder_generic #(
    parameter N = 2)
    
    (                  
    input  wire [(1<<N)-1:0] in,        
    input  wire  en,
    output reg  [N-1:0] out
);

integer i;

    always @(*) begin
        out = 0;
        if (en)
            for (i = 0; i < (1<<N); i = i + 1)
                if (in[i]) out = i;
    end

endmodule