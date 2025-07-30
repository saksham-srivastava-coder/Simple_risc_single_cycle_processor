module Reg(
    input clk,
    input reset,
    input [2:0] readAdd1,
    input [2:0] readAdd2,
    input [2:0] writeAdd,
    input [31:0] writeVal,
    input wr,
    output [31:0] out1,
    output [31:0] out2,
    integer i
    );
    reg [31:0] regFile [15:0];
    assign out1=regFile[readAdd1];
    assign out2=regFile[readAdd2];
    always@(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            for(i=0;i<16;i=i+1)
                regFile[i]<=32'b0;
        end
        else if(wr)
        begin
            regFile[writeAdd]<=writeVal;
        end
    end
endmodule
