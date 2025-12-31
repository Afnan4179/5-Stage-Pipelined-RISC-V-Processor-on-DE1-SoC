`timescale 1ns / 1ps

module mux_4x1(inp0, inp1, inp2, sel, out);

input logic [31 : 0] inp0, inp1, inp2;
input logic [1 : 0] sel;
output logic [31 : 0] out;

always_comb begin
    case(sel)
        2'b00: out = inp0;
        2'b01: out = inp1;
        2'b10: out = inp2;
        2'b11 : out = 32'd0;
        default:
            ;
    endcase
end

endmodule
