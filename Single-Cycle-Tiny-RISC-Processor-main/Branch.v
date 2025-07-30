`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 11:12:43
// Design Name: 
// Module Name: branch
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
module BranchUnit(
input Eq,
input Gt,
input isBeq,
input isBgt,
input isUBranch,
output isBranchTaken,
output Eeq,
output Egt
 );
 
 assign Eeq = isBeq & Eq;
 assign Gt = Gt & isBgt;
 
 assign isBranchTaken = isUBranch | Eeq | Egt ;
 
endmodule

module ForBranchPC(
    output reg [31:0] branchPC,
    input isRet,
    input [31:0] op1,
    input [31:0] branchTarget
);
    always @(*) begin
        branchPC = isRet ? op1 : branchTarget;
    end
endmodule
