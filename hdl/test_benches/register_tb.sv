module register_tb();
    reg clk;
    reg reset;
    reg [23:0] d_in;
    wire [23:0] d_out;

    SPI_register uut(
        .clk(clk),
        .reset(reset),
        .d_in(d_in),
        .d_out(d_out)
    );
    
    initial begin
        clk = 0;
        reset = 1;
        d_in = 24'b0;
        test_register();    
    end

task test_register();
    begin
        #20 reset = 0;

        #10 d_in = 24'h064;
        $display("Time: %0t | Applied d_in = %h", $time, d_in);
        $display("Time: %0t | Applied d_in = %d", $time, d_in);
        #20 d_in = 24'h00;
        $display("Time: %0t | Applied d_in = %h", $time, d_in);
        $display("Time: %0t | Applied d_in = %d", $time, d_in);
        #30 d_in = 24'h044 ;
        $display("Time: %0t | Applied d_in = %h", $time, d_in);
        $display("Time: %0t | Applied d_in = %d", $time, d_in);
        #100 $stop;
    end
endtask

endmodule
