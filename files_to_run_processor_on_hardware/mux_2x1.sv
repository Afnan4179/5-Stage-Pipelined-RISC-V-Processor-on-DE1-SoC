`timescale 1ns / 1ps

module mux2x1(inp0, inp1, sel, out);
    input logic [31 : 0] inp0, inp1;
    input logic sel;
    output logic [31 : 0] out;

    always_comb begin
        if(sel==1)
            out = inp1;
        else
            out = inp0; 
    end

endmodule

module mux2x1_Hazard(inp0, inp1, sel, out);
    input logic [176 : 0] inp0, inp1;
    input logic sel;
    output logic [176 : 0] out;

    always_comb begin
        if(sel==1)
            out = inp1;
        else
            out = inp0; 
    end

endmodule
