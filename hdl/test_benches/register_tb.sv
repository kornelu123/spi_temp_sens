module register_tb;
    reg clk;
    reg [23:0] d_in;
    wire [15:0] d_out;

    SPI_register register_test(
        .new_data(clk),
        .in(d_in),
        .out(d_out)
    );
    
    always #5 clk=~clk;

    initial begin
        clk = 0;
        d_in = 24'b0;
        test_register();    
    end

task test_register();
    begin
        $monitor("Time: %0t  Applied d_in = %d | out = %b %b %b %b  ", $time, d_in[23:8], d_out[15:12], d_out[11:8], d_out[7:4], d_out[3:0]);
        #10 d_in = 24'h006464;
        #20 d_in = 24'h00;
        #30 d_in = 24'h04444 ;
        #100 $finish;
    end
endtask

endmodule
