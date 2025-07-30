module DataMem (
    input clk,
    input [31:0] address,
    input [31:0] writeVal,
    input rd,
    input wr,
    output [31:0] readData
);
    reg [31:0] memory [0:255];

    always @(posedge clk) begin
        if (wr)
            memory[address[9:2]] <= writeVal;
    end

    assign readData = (rd) ? memory[address[9:2]] : 32'b0;
endmodule
