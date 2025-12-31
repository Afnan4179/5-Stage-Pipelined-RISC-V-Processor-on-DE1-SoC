`timescale 1ns / 1ps

module Control_Unit(Inst, BrEq, BrLt, PC_Sel, ImmSel,Read_Write_Bytes, RegWEn,Byte_Load_Store, BrUn, BSel, ASel, ALUSel, MemWR, WBSel);

input logic [31 : 0] Inst;
input logic BrLt, BrEq;
output logic PC_Sel, ASel, BSel, RegWEn, BrUn, MemWR;
output logic [2 : 0] ImmSel, Read_Write_Bytes;
output logic [1 : 0] WBSel, Byte_Load_Store;
output logic [3 : 0] ALUSel;
wire temp;

always_comb begin
    case(Inst[6 : 2])
    5'b01100: begin       //R type
        if(Inst[14 : 12] == 3'h0 && Inst[30] == 0) begin
            ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h0 && Inst[30] == 1) begin
            ALUSel = 4'd1; //SUB
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h1 && Inst[30] == 0) begin
            ALUSel = 4'd2; //SLL
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h2 && Inst[30] == 0) begin
            ALUSel = 4'd3; //Slt
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h3 && Inst[30] == 0) begin
            ALUSel = 4'd4; //Slt(U)
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h4 && Inst[30] == 0) begin
            ALUSel = 4'd5; //XOR
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h5 && Inst[30] == 0) begin
            ALUSel = 4'd6; //SRL
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h5 && Inst[30] == 1) begin
            ALUSel = 4'd7; //SRA
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h6 && Inst[30] == 0) begin
            ALUSel = 4'd8; //OR
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h7 && Inst[30] == 0) begin
            ALUSel = 4'd9; //AND
            ASel = 0;
            BSel = 0;
            ImmSel = 3'bxxx;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else
            ;
    end
//Start of I-type
    5'b00100: begin
        if(Inst[14 : 12] == 0) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b000;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 4) begin
             ALUSel = 4'd5; //XOR
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 6) begin
             ALUSel = 4'd8; //OR
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 7) begin
             ALUSel = 4'd9; //AND
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 1 && Inst[30] == 0) begin
            ALUSel = 4'd2; //SLL
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 5 && Inst[30] == 0) begin
             ALUSel = 4'd6; //SRL
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 5 && Inst[30] == 1) begin
             ALUSel = 4'd7; //SRA
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 2) begin
             ALUSel = 4'd3; //Slt
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3) begin
             ALUSel = 4'd4; //Slt(U)
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 1;
        end
        else
            ;
    end //I type with opcode = 0010011 ends here
//I-Type with opcode = 000011
    5'b00000: begin
        if(Inst[14 : 12] == 0) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b1;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 0;
            Read_Write_Bytes = Inst[14 : 12];
            Byte_Load_Store = Inst[21 : 20];
        end
        else if(Inst[14 : 12] == 1) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b1;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 0;
            Read_Write_Bytes = Inst[14 : 12];
            Byte_Load_Store = Inst[21 : 20];
        end
        else if(Inst[14 : 12] == 2) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b0;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 0;
            Read_Write_Bytes = Inst[14 : 12];
            Byte_Load_Store = 2'bxx;
        end
        else if(Inst[14 : 12] == 4) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b1;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 0;
            Read_Write_Bytes = Inst[14 : 12];
            Byte_Load_Store = Inst[21 : 20];
        end
        else if(Inst[14 : 12] == 5) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'b1;
            PC_Sel = 0;
            RegWEn = 1;
            BrUn = 1'bx;
            MemWR = 0;
            WBSel = 0;
            Read_Write_Bytes = Inst[14 : 12];
            Byte_Load_Store = Inst[21 : 20];
        end
        else 
            ;
        end //I Type ends here
        //S type starts
    5'b01000: begin
        if(Inst[14 : 12] == 0) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'd2;
            PC_Sel = 0;
            RegWEn = 0;
            BrUn = 1'bx;
            MemWR = 1;
            WBSel = 2'bxx;
            Read_Write_Bytes = Inst[14 : 12];
            Byte_Load_Store = Inst[8 : 7];
        end
        else if(Inst[14 : 12] == 1) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'd2;
            PC_Sel = 0;
            RegWEn = 0;
            BrUn = 1'bx;
            MemWR = 1;
            WBSel = 2'bxx;
            Read_Write_Bytes = Inst[14 : 12];
            Byte_Load_Store = Inst[8 : 7];
        end
        else if(Inst[14 : 12] == 2) begin
             ALUSel = 4'd0; //ADD
            ASel = 0;
            BSel = 1;
            ImmSel = 3'd6;
            PC_Sel = 0;
            RegWEn = 0;
            BrUn = 1'bx;
            MemWR = 1;
            WBSel = 2'bxx;
            Read_Write_Bytes = Inst[14 : 12];
            Byte_Load_Store = 2'bxx;
        end
        else
            ;
    end //S Type ends here
    //B Type starts here
    5'b11000: begin
        if(Inst[14 : 12] == 0) begin
             BrUn = 0;
             ImmSel = 3'd3;
             
             if(BrEq == 1) begin
                ALUSel = 4'd0; //ADD
                ASel = 1;
                BSel = 1;
                PC_Sel = 1;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
             else begin
                ALUSel = 4'dx; //No operation matters
                ASel = 1'bx;
                BSel = 1'bx;
                PC_Sel = 0;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2'bxx;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
        end
        else if(Inst[14 : 12] == 1) begin
             BrUn = 0;
             ImmSel = 3'd3;

             if(!(BrEq == 1)) begin
                ALUSel = 4'd0; //ADD
                ASel = 1;
                BSel = 1;
                PC_Sel = 1;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
             else begin
                ALUSel = 4'dx; //No operation matters
                ASel = 1'bx;
                BSel = 1'bx;
                PC_Sel = 0;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2'bxx;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
        end
        else if(Inst[14 : 12] == 4) begin
             BrUn = 0;
             ImmSel = 3'd3;

             if(BrLt == 1) begin
                ALUSel = 4'd0; //ADD
                ASel = 1;
                BSel = 1;
                PC_Sel = 1;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
             else begin
                ALUSel = 4'dx; //No operation matters
                ASel = 1'bx;
                BSel = 1'bx;
                PC_Sel = 0;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2'bxx;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
        end
        else if(Inst[14 : 12] == 5) begin
             BrUn = 0;
             ImmSel = 3'd3;

             if(!(BrLt == 1)) begin
                ALUSel = 4'd0; //ADD
                ASel = 1;
                BSel = 1;
                PC_Sel = 1;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
             else begin
                ALUSel = 4'dx; //No operation matters
                ASel = 1'bx;
                BSel = 1'bx;
                PC_Sel = 0;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2'bxx;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
        end
        else if(Inst[14 : 12] == 6) begin
             BrUn = 1;
             ImmSel = 3'd3;

             if(BrLt == 1) begin
                ALUSel = 4'd0; //ADD
                ASel = 1;
                BSel = 1;
                PC_Sel = 1;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
             else begin
                ALUSel = 4'dx; //No operation matters
                ASel = 1'bx;
                BSel = 1'bx;
                PC_Sel = 0;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2'bxx;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
        end
        else if(Inst[14 : 12] == 7) begin
             BrUn = 1;
             ImmSel = 3'd3;

             if(!(BrLt == 1)) begin
                ALUSel = 4'd0; //ADD
                ASel = 1;
                BSel = 1;
                PC_Sel = 1;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
             else begin
                ALUSel = 4'dx; //No operation matters
                ASel = 1'bx;
                BSel = 1'bx;
                PC_Sel = 0;
                RegWEn = 0;
                MemWR = 0;
                WBSel = 2'bxx;
                Read_Write_Bytes = 3'bxxx;
                Byte_Load_Store = 2'bxx;
             end
        end
        else
            ;
    end //B type ends here
    //jal starts here
    5'b11011: begin
        ALUSel = 4'd0; //ADD
        ASel = 1;
        BSel = 1;
        ImmSel = 3'd4;
        PC_Sel = 1;
        RegWEn = 1;
        BrUn = 1'bx;
        MemWR = 0;
        WBSel = 2; 
    end //jal ends here
    //jalr starts here
    5'b11001: begin
        if(Inst[14 : 12] == 0) begin
            ALUSel = 4'd0; //ADD
            ASel = 0;  // Mux of data1
            BSel = 1;  // Mux of data2
            ImmSel = 3'd0;  //Immediate selection bit
            PC_Sel = 1;  //PC select mux
            RegWEn = 1;    //Reg file enable
            BrUn = 1'bx;    //Branch unsigned
            MemWR = 0;      //data memory write enable
            WBSel = 2;  //
        end
    end //jalr ends here
    //lui starts from here
    5'b01101: begin
        ALUSel = 4'd10; //Sll by 12 bits
        ASel = 1'bx;
        BSel = 1;
        ImmSel = 3'd5;
        PC_Sel = 0;
        RegWEn = 1;
        BrUn = 1'bx;
        MemWR = 0;
        WBSel = 1;
    end //lui ends here.
    //auipc starts from here
    5'b00101: begin
        ALUSel = 4'd11; //Sll by 12 bits then add to PC.
        ASel = 1;
        BSel = 1;
        ImmSel = 3'd5;
        PC_Sel = 0;
        RegWEn = 1;
        BrUn = 1'bx;
        MemWR = 0;
        WBSel = 1;
    end //auipc ends here
    endcase
end



endmodule
