module presc_tb();

reg clk_in;
wire clk_out;

presc presc_0(
               .clk_in_p(clk_in),
               .clk_out_p(clk_out)
             );

integer i;

initial begin
  clk_in = 1'b0;
  $monitor("time:%d clk_out:%b", $time, clk_out);
  test_presc();
  $finish;
end

task test_presc();
  begin
    for(i=0; i<256; i=i+1) begin
      clk_in = ~clk_in;
      #1;
      clk_in = ~clk_in;
      #1;
    end
  end
endtask

endmodule
