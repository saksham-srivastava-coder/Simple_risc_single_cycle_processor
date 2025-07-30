module mux_mem(
    input [31:0] alu_Res,
    input [31:0] ldResult,
    input [31:0] pc,
    input isLd,
    input isCall,
    output reg [31:0] out_data
    );
    reg [1:0] sel;
    always@(*)
    begin
        sel={isCall,isLd};
        if(sel==2'b00) 
        begin
            out_data=alu_Res;
        end
        else if(sel==2'b01)
        begin
            out_data=ldResult;
        end
        else
        begin
            out_data=pc;
        end
    end
endmodule
