`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 11:16:55
// Design Name: 
// Module Name: instruction_decoder
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
module instruction_decoder (
    input [31:0] instruction,   // 32-bit instruction
    output [4:0] opcode,        // bits [28-32]
    output       I,             // Immediate bit [27]
    output [3:0] rd,            // Destination register [23-26]
    output [3:0] rs1,           // Source register 1 [19-22]
    output [3:0] rs2,           // Source register 2 [15-18]
    output [17:0] imm18,        // Immediate field [1-18]
    output [26:0] offset        // Branch offset [1-27]
);

    assign opcode = instruction[31:27];
    assign I      = instruction[26];
    assign rd     = instruction[25:22];
    assign rs1    = instruction[21:18];
    assign rs2    = instruction[17:14];
    assign imm18  = instruction[17:0];
    assign offset = instruction[26:0];

endmodule
