`timescale 1ns / 1ps

module tb_top_module;

    reg clk;
    reg rst;

    // Instantiate the top module
    top_module uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset and simulation control
    initial begin
        rst = 1;
        #20 rst = 0;

        // Run simulation for some time
        #500 $finish;
    end

endmodule
