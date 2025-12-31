`timescale 1ns / 1ps

// --- Module 1: Standard Pipeline Register ---
module pipe_reg #(parameter Width = 32)(
    input  logic clk, rst,
    input  logic [Width - 1 : 0] inp,
    output logic [Width - 1 : 0] out
);
    always_ff @(posedge clk) begin
        if (rst) 
            out <= {Width{1'b0}}; 
        else 
            out <= inp;
    end
endmodule

// --- Module 2: Pipeline Register with Enable & Flush ---
module pipe_reg_with_low #(parameter Width = 32)(
    input  logic clk, rst,
    input  logic Write_Enable, flush,
    input  logic [Width - 1 : 0] inp,
    output logic [Width - 1 : 0] out
);
    always_ff @(posedge clk) begin
        if (rst || flush) 
            out <= {Width{1'b0}};
        // If Write_Enable is 0, the register updates (Normal flow)
        // If Write_Enable is 1, the register holds its value (Stall)
        else if (!Write_Enable) 
            out <= inp;
        else
            out <= out;
    end
endmodule

// --- Module 3: Pipeline Register with Flush only ---
module pipe_reg_with_flush #(parameter Width = 32)(
    input  logic clk, rst, flush,
    input  logic [Width - 1 : 0] inp,
    output logic [Width - 1 : 0] out
);
    always_ff @(posedge clk) begin
        if (rst || flush) 
            out <= {Width{1'b0}};
        else
            out <= inp;
    end
endmodule