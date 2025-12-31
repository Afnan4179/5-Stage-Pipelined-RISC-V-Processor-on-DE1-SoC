`timescale 1ns / 1ps

module imm_gen(
    input  logic [31:0] inst,
    input  logic [2:0]  ImmSel,
    output logic [31:0] imm
);

    always_comb begin
        case(ImmSel)
            // Case 0: I-Type (Arithmetic like addi)
            3'd0: imm = {{20{inst[31]}}, inst[31:20]};
            
            // Case 1: I-Type (Loads like lw) - Same format as 0
            3'd1: imm = {{20{inst[31]}}, inst[31:20]};
            
            // Case 2: S-Type (Stores like sw)
            3'd2: imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
            
            // Case 3: B-Type (Branches like beq)
            3'd3: imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            
            // Case 4: J-Type (JAL) - THIS MATCHES YOUR CONTROL UNIT NOW
            3'd4: imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            
            // Case 5: U-Type (LUI, AUIPC)
            3'd5: imm = {inst[31:12], 12'b0}; 

            default: imm = 32'b0;
        endcase
    end
endmodule