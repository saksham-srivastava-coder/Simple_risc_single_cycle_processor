`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 18:10:53
// Design Name: 
// Module Name: program_counter
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
module program_counter(clk,reset,pc_in,pc_out,is_branch,branch_addr);
input clk,reset,is_branch;
input [31:0]pc_in,branch_addr;
output reg [31:0]pc_out;

always @(posedge clk)
begin
if (reset) 
    pc_out <=32'd0;
    
else if(is_branch)
    pc_out <=branch_addr;
    
else  
    pc_out <=pc_in+1;
end
endmodule


// instruction_memory.v
module instruction_memory (
    input [31:0] pc,      // Address from the Program Counter (PC)
    output [31:0] instr     // Instruction at the given address
);

    // Memory array: 256 words of 32-bit instruction memory (1 KB total)
    reg [31:0] memory [0:255];

    // Initialize memory contents from an external file (optional)
    initial begin
        $readmemh("instructions.mem", memory); // You can also use $readmemb for binary
    end

    // Instruction fetch (assuming word-aligned address)
    assign instr = memory[pc]; // addr[9:2] = 8-bit index (shift right by 2 for word-alignment)

endmodule
