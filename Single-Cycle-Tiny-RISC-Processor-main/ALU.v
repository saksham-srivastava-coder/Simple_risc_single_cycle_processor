`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 11:14:09
// Design Name: 
// Module Name: ALU
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [31:0] imm,
    input isImmediate,
    input isAdd,
    input isSub,
    input isCmp,
    input isMul,
    input isDiv,
    input isMod,
    input isLsl,
    input isLsr,
    input isAsr,
    input isOr,
    input isNot,
    input isAnd,
    input isMov,
    output Eq,
    output Gt,
    output wrFlag,
    input clk,
    output [31:0] aluResult
);

    wire [31:0] Bin;
    wire [31:0] out [0:4];

    mux2to1 mux_inst1 (
        .Bin(Bin),
        .isImmediate(isImmediate),
        .B(B),
        .imm(imm)
    );

    add add_inst (
        .A(A),
        .Bin(Bin),
        .result(out[0]),
        .isAdd(isAdd),
        .isSub(isSub),
        .isMul(isMul),
        .isCmp(isCmp),
        .wrFlag(wrFlag),
        .clk(clk)
    );

   // mul mul_inst (
     //   .A(A),
       // .Bin(Bin),
        //.isMul(isMul),
        //.result(out[1])
    //);

    divmod div_inst (
        .A(A),
        .Bin(Bin),
        .isDiv(isDiv),
        .isMod(isMod),
        .result(out[1])
    );

    shift shift_inst (
        .A(A),
        .Bin(Bin),
        .isLsl(isLsl),
        .isLsr(isLsr),
        .isAsr(isAsr),
        .result(out[2])
    );

    logic logic_inst (
        .A(A),
        .Bin(Bin),
        .isOr(isOr),
        .isAnd(isAnd),
        .isNot(isNot),
        .result(out[3])
    );

    mov mov_inst (
        .B(Bin),
        .isMov(isMov),
        .result(out[4])
    );
    
    mux5to1 mux_inst2 (
        .out(aluResult),
        .in0(out[0]),
        .in1(out[1]),
        .in2(out[2]),
        .in3(out[3]),
        .in4(out[4]),
        .sel(aluSel)
    );

    assign aluResult = out[0] | out[1] | out[2] | out[3] | out[4] ; // simplistic output selection

endmodule

module mux5to1 (
    output reg [31:0] out,
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [2:0] sel
);
    always @(*) begin
        case (sel)
            0: out <= in0;
            1: out <= in1;
            2: out <= in2;
            3: out <= in3;
            4: out <= in4;
           
            default: ;
        endcase
    end
endmodule

// Mux
module mux2to1(
    output reg [31:0] Bin,
    input isImmediate,
    input [31:0] B,
    input [31:0] imm
);
    always @(*) begin
        Bin = isImmediate ? imm : B;
    end
endmodule

//flag
module flags (
    output reg flagE,
    flagGt,
    input Eq,
    Gt,
    wr,
    clk,
    rst
);
    reg [1:0] flagRegister;  // flagRegister[0] is Equal

    always @(posedge clk) begin
        if (rst) begin
            flagRegister[0] = 0;
            flagRegister[1] = 0;
        end else if (wr) begin
            flagRegister[0] = Eq;
            flagRegister[1] = Gt;
        end
        flagE  = flagRegister[0];
        flagGt = flagRegister[1];

    end
endmodule


// ADD/SUB/MUL
module add(
    input [31:0] A,
    input [31:0] Bin,
    input isAdd,
    isSub,
    isCmp,
    isMul,
    output wrFlag,
    output [31:0] result
);
    assign wrFlag = isCmp;
    assign result = isSub ? A - Bin : (isAdd ? A + Bin : (isMul ? A * Bin : 0));
    assign Eq = isCmp ? (A == Bin ? 1 : 0) : 0;
    assign Gt = isCmp ? (A > Bin ? 1 : 0) : 0;
endmodule

// MUL
//module mul(
  //  input [31:0] A,
    //input [31:0] Bin,
    //input isMul,
    //output [31:0] result
//);
  //  assign result = isMul ? A * Bin : 0;
//endmodule

// DIV/MOD
module divmod(
    input [31:0] A,
    input [31:0] Bin,
    input isDiv,
    input isMod,
    output [31:0] result
);
    assign result = isMod ? A % Bin : (isDiv ? A / Bin : 0);
endmodule

// SHIFT
module shift(
    input [31:0] A,
    input [31:0] Bin,
    input isLsl,
    input isLsr,
    input isAsr,
    output reg [31:0] result
);
    always @(*) begin
        if (isLsl)
            result = A << Bin;
        else if (isLsr)
            result = A >> Bin;
        else if (isAsr)
            result = A >>> Bin;
        else
            result = 0;
    end
endmodule

// LOGIC
module logic(
    input [31:0] A,
    input [31:0] Bin,
    input isOr,
    input isAnd,
    input isNot,
    output [31:0] result
);
    assign result = isOr ? (A | Bin) : (isAnd ? (A & Bin) : (isNot ? ~A : 0));
endmodule

// MOV
module mov(
    input [31:0] B,
    input isMov,
    output [31:0] result
);
    assign result = isMov ? B : 0;
endmodule
