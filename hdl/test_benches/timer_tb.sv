module timer_tb();

reg clk;
wire sig; 

timer #(
          .time_ms(1)
        )
        tim0 
        ( 
         .clk_in(clk),
         .sig_out(sig)
        );

integer i;

task test_timer();
  begin
    for(i=0; i<1234000*3; i=i+1) begin
      clk <= ~clk;
      #10;
      clk <= ~clk;
      #10;
    end
  end
endtask

initial begin
  clk <= 1'b0;
  $monitor("sig:%b", sig);
  test_timer();
  $finish;
end

endmodule
