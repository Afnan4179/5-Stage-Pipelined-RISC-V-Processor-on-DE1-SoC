`timescale 1ns / 1ps

module Reg_file(
    input logic clk, 
    input logic rst,        
    input logic Register_E, // Write Enable
    input logic [4:0] rsW,  // Write Address
    input logic [4:0] rs1,  // Read Address 1
    input logic [4:0] rs2,  // Read Address 2
    input logic [31:0] dataW, 
    output logic [31:0] data1, 
    output logic [31:0] data2
);

    logic [31:0] reg_file [0:31];

    // Asynchronous Read
    // Always ensures x0 is 0
    always_comb begin
        data1 = (rs1 == 5'b0) ? 32'b0 : reg_file[rs1];
        data2 = (rs2 == 5'b0) ? 32'b0 : reg_file[rs2];
    end

    // Sequential Write 
    // Fixed: Using posedge for reset to ensure synchronization with the testbench
    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < 32; i++) begin
                reg_file[i] <= 32'b0;
            end
        end 
        // Write occurs on the falling edge or rising edge depending on design
        // Most RISC-V designs write on posedge to stay synchronous
        else if (Register_E && rsW != 5'b0) begin
            reg_file[rsW] <= dataW;
        end
    end

endmodule