module edge_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire Rise_Tick,
    input  wire Fall_Tick,
    input  wire Edge_Tick,
    output wire [3:0] Rise_Count,
    output wire [3:0] Fall_Count,
    output wire [3:0] Edge_Count   
);

    reg [3:0] rise_count_reg;
    reg [3:0] fall_count_reg;
    reg [3:0] edge_count_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            rise_count_reg <= 4'b0000;
        else if (Rise_Tick)
            rise_count_reg <= rise_count_reg + 1'b1;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            fall_count_reg <= 4'b0000;
        else if (Fall_Tick)
            fall_count_reg <= fall_count_reg + 1'b1;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            edge_count_reg <= 4'b0000;
        else if (Edge_Tick)
            edge_count_reg <= edge_count_reg + 1'b1;
    end

    assign Rise_Count = rise_count_reg;
    assign Fall_Count = fall_count_reg;
    assign Edge_Count = edge_count_reg;

endmodule