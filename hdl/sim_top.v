module sim_top;
    reg clk;
    reg reset;
    reg [31:0] d_in;
    wire [31:0] d_out;

    timer_tb timer_test();
    presc_tb presc_test();
endmodule
