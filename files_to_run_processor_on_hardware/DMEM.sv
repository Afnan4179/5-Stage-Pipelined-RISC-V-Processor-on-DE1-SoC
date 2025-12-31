`timescale 1ns / 1ps

module DMEM(
    input logic [31 : 0] addr, 
    input logic [31 : 0] dataW, 
    input logic MemRW, 
    input logic clk, 
    input logic rst, // Added rst for safe initialization
    input logic [2 : 0] Read_Write_Bytes, 
    input logic [1 : 0] Byte_Load_Store, 
    output logic [31 : 0] dataR
);

    logic [31 : 0] memory [0 : 15];

    // All memory modifications (Reset + Write) happen in ONE block
    always_ff @(posedge clk) begin
        if (rst) begin
            // Initialize memory on reset
            for (int i = 0; i < 16; i++) memory[i] <= 32'b0;
            memory[3]  <= 32'd05;
            memory[4]  <= 32'd06;
            memory[5]  <= 32'd07;
            memory[6]  <= 32'd08;
            memory[7]  <= 32'd09;
            memory[8]  <= 32'd10;
            memory[9]  <= 32'd11;
            memory[10] <= 32'hBAFEDCBA;
            memory[14] <= 32'hABCDEFAB;
        end 
        else if (MemRW) begin
            case(Read_Write_Bytes)
                3'b010: memory[addr[3:0]] <= dataW; // Word Store
                3'b000: begin // Byte Store
                    if(Byte_Load_Store == 0)      memory[addr[3:0]][7:0]   <= dataW[7:0];
                    else if(Byte_Load_Store == 1) memory[addr[3:0]][15:8]  <= dataW[7:0];
                    else if(Byte_Load_Store == 2) memory[addr[3:0]][23:16] <= dataW[7:0];
                    else                          memory[addr[3:0]][31:24] <= dataW[7:0];
                end
                default: ;
            endcase
        end
    end

    // Combinational Read Logic
    always_comb begin
        if (!MemRW) begin
            case(Read_Write_Bytes)
                3'b010:  dataR = memory[addr[3:0]];
                3'b000: begin 
                    if(Byte_Load_Store == 0)      dataR = {{24{memory[addr[3:0]][7]}},  memory[addr[3:0]][7:0]};
                    else if(Byte_Load_Store == 1) dataR = {{24{memory[addr[3:0]][15]}}, memory[addr[3:0]][15:8]};
                    else                          dataR = 32'b0;
                end
                default: dataR = 32'h0;
            endcase
        end else begin
            dataR = 32'h0;
        end
    end
endmodule