`timescale 1ns / 1ps

module control_unit (
    input [4:0] opcode,        // Instruction opcode
    input       I,             // Immediate bit
    input       eq_flag,       // Equality flag from ALU
    input       gt_flag,       // Greater-than flag from ALU

    output reg is_add,
    output reg is_sub,
    output reg is_mul,
    output reg is_div,
    output reg is_mod,
    output reg is_cmp,
    output reg is_and,
    output reg is_or,
    output reg is_not,
    output reg is_mov,
    output reg is_lsl,
    output reg is_lsr,
    output reg is_asr,
    output reg is_nop,
    output reg is_ld,
    output reg is_st,
    output reg is_beq,
    output reg is_bgt,
    output reg is_b,
    output reg is_call,
    output reg is_ret,

    output reg is_immediate,   // Whether immediate is used
    output reg is_wb,          // Register write-back
    output reg is_branch,      // Any type of branch
    output reg [4:0] alu_signal // ALU control
);

always @(*) begin
    // Default values
    {is_add, is_sub, is_mul, is_div, is_mod, is_cmp,
     is_and, is_or, is_not, is_mov, is_lsl, is_lsr, is_asr, is_nop,
     is_ld, is_st, is_beq, is_bgt, is_b, is_call, is_ret,
     is_wb, is_branch} = 22'b0;

    alu_signal = opcode;
    is_immediate = (I == 1);

    case (opcode)
        5'b00000: begin is_add = 1; is_wb = 1; end
        5'b00001: begin is_sub = 1; is_wb = 1; end
        5'b00010: begin is_mul = 1; is_wb = 1; end
        5'b00011: begin is_div = 1; is_wb = 1; end
        5'b00100: begin is_mod = 1; is_wb = 1; end
        5'b00101: begin is_cmp = 1; end
        5'b00110: begin is_and = 1; is_wb = 1; end
        5'b00111: begin is_or  = 1; is_wb = 1; end
        5'b01000: begin is_not = 1; is_wb = 1; end
        5'b01001: begin is_mov = 1; is_wb = 1; end
        5'b01010: begin is_lsl = 1; is_wb = 1; end
        5'b01011: begin is_lsr = 1; is_wb = 1; end
        5'b01100: begin is_asr = 1; is_wb = 1; end
        5'b01101: begin is_nop = 1; end
        5'b01110: begin is_ld  = 1; is_wb = 1; end
        5'b01111: begin is_st  = 1; end
        5'b10000: begin is_beq = eq_flag;  is_branch = 1; end
        5'b10001: begin is_bgt = gt_flag;  is_branch = 1; end
        5'b10010: begin is_b   = 1;         is_branch = 1; end
        5'b10011: begin is_call = 1; is_wb = 1; is_branch = 1; end
        5'b10100: begin is_ret = 1;  is_branch = 1; end
    endcase
end

endmodule
