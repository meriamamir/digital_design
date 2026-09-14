

module debounce_fsm (
    input  wire clk,
    input  wire reset,
    input  wire sw,       
    input  wire m_tick,   
    output reg  debounced_out 
);


    localparam [2:0]
        zero    = 3'b000,
        wait1_1 = 3'b001,
        wait1_2 = 3'b010,
        wait1_3 = 3'b011,
        one     = 3'b100,
        wait0_1 = 3'b101,
        wait0_2 = 3'b110,
        wait0_3 = 3'b111;

    reg [2:0] state_reg, state_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
    end


    always @(*) begin
        state_next = state_reg;   // default: self-loop (hold state)

        case (state_reg)

            // input settling toward 0 
            zero:
                if (sw)
                    state_next = wait1_1;      // sw: zero -> wait1_1
                                               // else: sw' self-loop, stay in zero

            wait1_1:
                if (!sw)
                    state_next = zero;         // sw': bounce, restart
                else if (m_tick)
                    state_next = wait1_2;      // sw.m_tick: advance
                                             // else: sw & ~m_tick -> hold (implicit self-loop)

            wait1_2:
                if (!sw)
                    state_next = zero;
                else if (m_tick)
                    state_next = wait1_3;

            wait1_3:
                if (!sw)
                    state_next = zero;
                else if (m_tick)
                    state_next = one;          // stabilized at 1

            // ---- right branch: input settling toward 1 ----
            one:
                if (!sw)
                    state_next = wait0_1;      // sw': one -> wait0_1
                                               // else: sw self-loop, stay in one

            wait0_1:
                if (sw)
                    state_next = one;          // sw: bounce, restart
                else if (m_tick)
                    state_next = wait0_2;      // sw'.m_tick: advance
                                               // else: sw' & ~m_tick -> hold

            wait0_2:
                if (sw)
                    state_next = one;
                else if (m_tick)
                    state_next = wait0_3;

            wait0_3:
                if (sw)
                    state_next = one;
                else if (m_tick)
                    state_next = zero;         // stabilized at 0

            default:
                state_next = zero;

        endcase
    end

    always @(*) begin
        case (state_reg)
            one, wait0_1, wait0_2, wait0_3: debounced_out = 1'b1;
            default:                        debounced_out = 1'b0;
        endcase
    end

endmodule