module inst_mem(input logic [31:0] addr, output logic [31:0] dataR);
    logic [31:0] registers [0:255]; 

    initial begin
        // Initialize to 0
        for (int i=0; i<256; i++) registers[i] = 0;

        // "Forever Fibonacci" Program
        registers[0] = 32'h00000093;
        registers[1] = 32'h00000013;
        registers[2] = 32'h00000013;
        registers[3] = 32'h00000013;
        registers[4] = 32'h00000013;
        registers[5] = 32'h00100113;
        registers[6] = 32'h00000013;
        registers[7] = 32'h00000013;
        registers[8] = 32'h00000013;
        registers[9] = 32'h00000013;
        registers[10] = 32'h002081B3;
        registers[11] = 32'h00000013;
        registers[12] = 32'h00000013;
        registers[13] = 32'h00000013;
        registers[14] = 32'h00000013;
        registers[15] = 32'h000100B3;
        registers[16] = 32'h00000013;
        registers[17] = 32'h00000013;
        registers[18] = 32'h00000013;
        registers[19] = 32'h00000013;
        registers[20] = 32'h00018133;
        registers[21] = 32'h00000013;
        registers[22] = 32'h00000013;
        registers[23] = 32'h00000013;
        registers[24] = 32'h00000013;
        registers[25] = 32'hFC5FF06F; // The Jump
    end

    assign dataR = registers[addr[31:2]]; 
endmodule