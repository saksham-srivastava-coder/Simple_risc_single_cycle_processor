`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 11:51:28
// Design Name: 
// Module Name: top_module
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
module top(clk,reset,pc_in);
    input clk,reset,pc_in;
    wire pc; // instruction mem
    program_counter pc0(clk,reset,pc_in,pc);

    wire instr;
    instruction_memory im0(pc,instr);
    wire opcode,I,rd,rs1,rs2,imm18,offset; // instruction  decoder
    instruction_decoder id0(instr,opcode,I,rd,rs1,rs2,imm18,offset);
    wire eq,gt;  //Flag
    flags fg(eq,gt,eq_alu,gt_alu,wr,clk,rst);
    wire IsSt,IsLd,IsBeq,IsBgt,IsRet,IsImmediate,IsWb,IsUBranch,IsCall,AluSignal;
    control_unit cu0(
opcode,I,eq_flag,gt_flag,is_add,
is_sub,
is_mul,
is_div,
is_mod,
is_cmp,
is_and,
is_or,
is_not,
is_mov,
is_lsl,
is_lsr,
s_asr,
is_nop,
is_ld,
is_st,
is_beq,
is_bgt,
is_b,
is_call,
is_ret,
is_immediate,is_wb,is_branch,alu_signal);
    wire IsBranchTaken,Eeq,Egt;
    BranchUnit bu0(eq,gt,IsBeq,IsBgt,IsUBranch,IsBranchTaken,Eeq,Egt);
    
    wire A,B,imm,isImmediate,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,
    isNot,isAnd,isMov;
    wire aluResult;
    ALU alu(clk,A,B,imm,isImmediate,isAdd,isSub,isCmp,isMul,isDiv,isMod,isLsl,isLsr,isAsr,isOr,
    isNot,isAnd,isMov,eq_alu,gt_alu,wr,aluResult);
    wire address,writeVal,rd,wr,readData;
    DataMem (clk,address,writeVal,rd,wr,readData);
    wire branchPC,isRet,op1,branchTarget;
    ForBranchPC(branchPC,isRet,op1,branchTarget);
    
    wire reset,readAdd1,readAdd2,writeAdd,writeVal,wr,out1,out2,i;
    Reg regi(clk,reset,readAdd1,readAdd2,writeAdd,writeVal,wr,out1,out2,i);
endmodule   


//module top(clk,reset,opcode);
    
//    wire IsSt,IsLd,IsBeq,IsBgt,IsRet,IsImmediate,IsWb,IsUBranch,IsCall,AluSignal; //Control_unit
//    wire isBranchTaken,Eeq,Egt;     // BranchUnit
//    wire 
//    control_unit cu0(instr,I,eq,gt,IsSt,IsLd,IsBeq,IsBgt,IsRet,IsImmediate,IsWb,IsUBranch,IsCall,AluSignal);
//    BranchUnit bu0(eq,gt,isBeq,isBgt,isUBranch,isBranchTaken,Eeq,Egt);
//endmodule
