module six_seven_seg (
    input  wire rst_n,
    input  wire [3:0] Rise_Count,
    input  wire [3:0] Fall_Count,
    input  wire [3:0] Edge_Count,
    output reg  [6:0] R,  
    output reg  [6:0] R_c,
    output reg  [6:0] F,  
    output reg  [6:0] F_c,
    output reg  [6:0] t,  
    output reg  [6:0] t_c 
);


    localparam CHAR_N = 7'b1001000;
    localparam CHAR_U = 7'b1000001;
    localparam CHAR_L = 7'b1000111;
    localparam CHAR_R = 7'b0001000;
    localparam CHAR_F = 7'b0001110;
    localparam CHAR_T = 7'b0000111;
    localparam OFF    = 7'b1111111;

    function [6:0] hex_to_7seg(input [3:0] hex);
        case (hex)
            4'h0: hex_to_7seg = 7'b1000000; 
            4'h1: hex_to_7seg = 7'b1111001; 
            4'h2: hex_to_7seg = 7'b0100100; 
            4'h3: hex_to_7seg = 7'b0110000; 
            4'h4: hex_to_7seg = 7'b0011001; 
            4'h5: hex_to_7seg = 7'b0010010; 
            4'h6: hex_to_7seg = 7'b0000010; 
            4'h7: hex_to_7seg = 7'b1111000; 
            4'h8: hex_to_7seg = 7'b0000000; 
            4'h9: hex_to_7seg = 7'b0010000; 
            default: hex_to_7seg = OFF;
        endcase
    endfunction

    always @(*) begin
        if (!rst_n) begin

            R   = CHAR_N;
            R_c = CHAR_U;
            F   = CHAR_L;
            F_c = CHAR_L;
            t   = OFF;
            t_c = OFF;
        end else begin

            R   = CHAR_R;
            R_c = hex_to_7seg(Rise_Count);
            F   = CHAR_F;
            F_c = hex_to_7seg(Fall_Count);
            t   = CHAR_T;
            t_c = hex_to_7seg(Edge_Count);
        end
    end

endmodule