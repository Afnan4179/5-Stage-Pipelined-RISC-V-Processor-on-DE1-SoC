`timescale 1ns / 1ps

module Program_Counter(
    input  logic [31:0] PC_in,
    input  logic clk, 
    input  logic rst, 
    input  logic PC_Write,
    output logic [31:0] PC_Out
);

    // We use your working logic: Reset to 0
    always_ff @(posedge clk) begin
        if (rst) begin
            PC_Out <= 32'h0;
        end
        else if (PC_Write) begin
            PC_Out <= PC_in;
        end
    end

endmodule