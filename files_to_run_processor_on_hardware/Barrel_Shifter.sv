`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2024 02:49:54 PM
// Design Name: 
// Module Name: Barrel_Shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2024 02:49:54 PM
// Design Name: 
// Module Name: Barrel_Shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Barrel_Shifter(inp1, inp2, ALUSel, out);

input [31 : 0] inp1;
input [4 : 0] inp2;
input [3:0] ALUSel;
output reg [31 : 0] out;

always@(*)  begin
//For left Shift
if (ALUSel == 2)
begin
    case(inp2)
        5'd0:   out = inp1;
        5'd1:   out = {inp1[30 : 0] , 1'd0};
        5'd2:   out = {inp1[29 : 0] , 2'd0};
        5'd3:   out = {inp1[28 : 0] , 3'd0};
        5'd4:   out = {inp1[27 : 0] , 4'd0};
        5'd5:   out = {inp1[26 : 0] , 5'd0};
        5'd6:   out = {inp1[25 : 0] , 6'd0};
        5'd7:   out = {inp1[24 : 0] , 7'd0};
        5'd8:   out = {inp1[23 : 0] , 8'd0};
        5'd9:   out = {inp1[22 : 0] , 9'd0};
        5'd10:  out = {inp1[21 : 0] , 10'd0};
        5'd11:  out = {inp1[20 : 0] , 11'd0};
        5'd12:  out = {inp1[19 : 0] , 12'd0};
        5'd13:  out = {inp1[18 : 0] , 13'd0};
        5'd14:  out = {inp1[17 : 0] , 14'd0};
        5'd15:  out = {inp1[16 : 0] , 15'd0};
        5'd16:  out = {inp1[15 : 0] , 16'd0};
        5'd17:  out = {inp1[14 : 0] , 17'd0};
        5'd18:  out = {inp1[13 : 0] , 18'd0};
        5'd19:  out = {inp1[12 : 0] , 19'd0};
        5'd20:  out = {inp1[11 : 0] , 20'd0};
        5'd21:  out = {inp1[10 : 0] , 21'd0};
        5'd22:  out = {inp1[9  : 0] , 22'd0};
        5'd23:  out = {inp1[8  : 0] , 23'd0};
        5'd24:  out = {inp1[7  : 0] , 24'd0};
        5'd25:  out = {inp1[6  : 0] , 25'd0};
        5'd26:  out = {inp1[5  : 0] , 26'd0};
        5'd27:  out = {inp1[4  : 0] , 27'd0};
        5'd28:  out = {inp1[3  : 0] , 28'd0};
        5'd29:  out = {inp1[2  : 0] , 29'd0};
        5'd30:  out = {inp1[1  : 0] , 30'd0};
        5'd31:  out = {inp1[0] , 31'd0};   
        default: out = 32'd0;
    endcase
end
//For logical right shift
else if((ALUSel == 7 && inp1[31] == 0) || ALUSel == 6)
begin
    case(inp2)
        5'd0:   out = inp1;
        5'd1:   out = {1'd0, inp1[31 : 1]};
        5'd2:   out = {2'd0 , inp1[31 : 2]};
        5'd3:   out = {3'd0 , inp1[31 : 3]};
        5'd4:   out = {4'd0 , inp1[31 : 4]};
        5'd5:   out = {5'd0 , inp1[31 : 5]};
        5'd6:   out = {6'd0 , inp1[31 : 6]};
        5'd7:   out = {7'd0 , inp1[31 : 7]};
        5'd8:   out = {8'd0 , inp1[31 : 8]};
        5'd9:   out = {9'd0 , inp1[31 : 9]};
        5'd10:  out = {10'd0 , inp1[31 : 10]};
        5'd11:  out = {11'd0 , inp1[31 : 11]};
        5'd12:  out = {12'd0 , inp1[31 : 12]};
        5'd13:  out = {13'd0 , inp1[31 : 13]};
        5'd14:  out = {14'd0 , inp1[31 : 14]};
        5'd15:  out = {15'd0 , inp1[31 : 15]};
        5'd16:  out = {16'd0 , inp1[31 : 16]};
        5'd17:  out = {17'd0 , inp1[31 : 17]};
        5'd18:  out = {18'd0 , inp1[31 : 18]};
        5'd19:  out = {19'd0 , inp1[31 : 19]};
        5'd20:  out = {20'd0 , inp1[31 : 20]};
        5'd21:  out = {21'd0 , inp1[31 : 21]};
        5'd22:  out = {22'd0 , inp1[31 : 22]};
        5'd23:  out = {23'd0 , inp1[31 : 23]};
        5'd24:  out = {24'd0 , inp1[31 : 24]};
        5'd25:  out = {25'd0 , inp1[31 : 25]};
        5'd26:  out = {26'd0 , inp1[31 : 26]};
        5'd27:  out = {27'd0 , inp1[31 : 27]};
        5'd28:  out = {28'd0 , inp1[31 : 28]};
        5'd29:  out = {29'd0 , inp1[31 : 29]};
        5'd30:  out = {30'd0 , inp1[31 : 30]};
        5'd31:  out = {31'd0 , inp1[31]};  
        default: out = 32'd0;
    endcase
end
//For arithmetic right shift
else if(ALUSel == 7 && inp1[31] == 1)
begin
    case(inp2)
        5'd0:   out = inp1;
        5'd1:   out = {{1{1'b1}} , inp1[31 : 1]};
        5'd2:   out = {{2{1'b1}} , inp1[31 : 2]};
        5'd3:   out = {{3{1'b1}} , inp1[31 : 3]};
        5'd4:   out = {{4{1'b1}} , inp1[31 : 4]};
        5'd5:   out = {{5{1'b1}} , inp1[31 : 5]};
        5'd6:   out = {{6{1'b1}} , inp1[31 : 6]};
        5'd7:   out = {{7{1'b1}} , inp1[31 : 7]};
        5'd8:   out = {{8{1'b1}} , inp1[31 : 8]};
        5'd9:   out = {{9{1'b1}} , inp1[31 : 9]};
        5'd10:  out = {{10{1'b1}} , inp1[31 : 10]};
        5'd11:  out = {{11{1'b1}} , inp1[31 : 11]};
        5'd12:  out = {{12{1'b1}} , inp1[31 : 12]};
        5'd13:  out = {{13{1'b1}} , inp1[31 : 13]};
        5'd14:  out = {{14{1'b1}} , inp1[31 : 14]};
        5'd15:  out = {{15{1'b1}} , inp1[31 : 15]};
        5'd16:  out = {{16{1'b1}} , inp1[31 : 16]};
        5'd17:  out = {{17{1'b1}} , inp1[31 : 17]};
        5'd18:  out = {{18{1'b1}} , inp1[31 : 18]};
        5'd19:  out = {{19{1'b1}} , inp1[31 : 19]};
        5'd20:  out = {{20{1'b1}} , inp1[31 : 20]};
        5'd21:  out = {{21{1'b1}} , inp1[31 : 21]};
        5'd22:  out = {{22{1'b1}} , inp1[31 : 22]};
        5'd23:  out = {{23{1'b1}} , inp1[31 : 23]};
        5'd24:  out = {{24{1'b1}} , inp1[31 : 24]};
        5'd25:  out = {{25{1'b1}} , inp1[31 : 25]};
        5'd26:  out = {{26{1'b1}} , inp1[31 : 26]};
        5'd27:  out = {{27{1'b1}} , inp1[31 : 27]};
        5'd28:  out = {{28{1'b1}} , inp1[31 : 28]};
        5'd29:  out = {{29{1'b1}} , inp1[31 : 29]};
        5'd30:  out = {{30{1'b1}} , inp1[31 : 30]};
        5'd31:  out = {{31{1'b1}} , inp1[31]}; 
        default: out = 32'd0; 
    endcase
end
end
endmodule
