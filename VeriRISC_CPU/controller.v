module controller (
    input        zero,
    input  [2:0] opcode,
    input  [2:0] phase,

    output reg sel,
    output reg rd,
    output reg ld_ir,
    output reg halt,
    output reg inc_pc,
    output reg ld_ac,
    output reg ld_pc,
    output reg wr,
    output reg data_e
);

always @(*) begin

    sel    = 0;
    rd     = 0;
    ld_ir  = 0;
    inc_pc = 0;
    halt   = 0;
    ld_pc  = 0;
    data_e = 0;
    ld_ac  = 0;
    wr     = 0;

    case (phase)
        3'd0: begin // INST_ADDR
            sel = 1;
        end

        3'd1: begin // INST_FETCH
            sel = 1;
            rd  = 1;
        end

        3'd2: begin // INST_LOAD
            sel   = 1;
            rd    = 1;
            ld_ir = 1;
        end

        3'd3: begin // IDLE
            sel   = 1;
            rd    = 1;
            ld_ir = 1;
        end

        3'd4: begin  //OP_ADDR
          inc_pc = 1;
           if (opcode == 3'b000)begin
              halt = 1;
           end
  
         end

        3'd5: begin  //OP_FETCH
           if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) begin
                    rd = 1; 
           end
             
         end

        3'd6: begin         // ALU_OP
           if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) begin
                    rd = 1;
           end else if (opcode == 3'b001 && zero) begin  // SKZ && zero
                     inc_pc = 1;
           end else if (opcode == 3'b111) begin            // JMP
                     ld_pc = 1;
           end else if (opcode == 3'b110) begin            // STO
                     data_e = 1;
           end
        end
 

         3'd7: begin // STORE 
          
           if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) begin
              rd = 1;
              ld_ac = 1;
           end else if (opcode == 3'b110) begin  // STO
              wr = 1;
              data_e=1;
           end else if (opcode == 3'b111) begin   // JMP
              ld_pc = 1;
          end

          end

    endcase
end

endmodule