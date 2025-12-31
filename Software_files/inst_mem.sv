`timescale 1ns / 1ps

module inst_mem(
    input  logic [31:0] addr,
    output logic [31:0] dataR
);

    logic [31:0] memory [0:255]; // 256 Word Memory

    initial begin
        // 1. Initialize to 0 (NOP) to prevent 'X' if program is short
        for (int i = 0; i < 256; i++) begin
            memory[i] = 32'b0;
        end

        // 2. Load the Hex file
        // This looks for "test.hex" in the project folder
        $readmemh("test.hex", memory);
    end

    // Word Aligned Read
    assign dataR = memory[addr[31:2]]; 

endmodule