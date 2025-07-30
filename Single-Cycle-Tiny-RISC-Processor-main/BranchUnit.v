`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2025 19:58:19
// Design Name: 
// Module Name: BranchUnit
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
 assign Eeq = Gt & isBgt;
 
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
