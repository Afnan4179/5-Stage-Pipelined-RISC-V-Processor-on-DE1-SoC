`timescale 1ns / 1ps

module alu_logic(
    input  logic [3:0]  ALUSel,
    input  logic [31:0] inp1, 
    input  logic [31:0] inp2,
    output logic [31:0] out
);

    logic [31:0] BS_Out; // Wires to connect to the Barrel Shifter
    logic [31:0] temp;

    // --- INSTANTIATE BARREL SHIFTER ---
    Barrel_Shifter BS(
        .inp1(inp1), 
        .inp2(inp2[4:0]), // Only use lower 5 bits for shift amount
        .ALUSel(ALUSel), 
        .out(BS_Out)
    );

    always_comb begin
        // --- STEP 1: SET DEFAULTS (Fixes the Latch Error) ---
        out = 32'd0;
        temp = 32'd0;  // <--- This line fixes the error! 
                       // Now 'temp' has a value even when we aren't using AUIPC.

        case(ALUSel)
            4'd0:  out = inp1 + inp2;                  // ADD
            4'd1:  out = inp1 - inp2;                  // SUB
            
            // --- USE BARREL SHIFTER OUTPUT ---
            4'd2:  out = BS_Out;                       // SLL (Calculated by module)
            
            4'd3:  out = ($signed(inp1) < $signed(inp2)) ? 32'd1 : 32'd0; // SLT
            4'd4:  out = (inp1 < inp2) ? 32'd1 : 32'd0; // SLTU
            4'd5:  out = inp1 ^ inp2;                  // XOR
            
            // --- USE BARREL SHIFTER OUTPUT ---
            4'd6:  out = BS_Out;                       // SRL (Calculated by module)
            4'd7:  out = BS_Out;                       // SRA (Calculated by module)
            
            4'd8:  out = inp1 | inp2;                  // OR
            4'd9:  out = inp1 & inp2;                  // AND
            
            // LUI: Load Upper Immediate
            4'd10: out = inp2 << 12;                   
            
            // AUIPC: Add Upper Immediate to PC (inp1)
            4'd11: begin
                temp = inp2 << 12;
                out  = temp + inp1;
            end
            
            default: out = 32'd0;
        endcase
    end

endmodule