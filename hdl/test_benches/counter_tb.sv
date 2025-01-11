module counter_tb();

  reg clk; 
  reg btn_mock;
  wire [23:0] count_value;

counter test_counter(
    .clk(clk),
    .rst(btn_mock),
    .count(count_value)
    );

    always #5 clk=~clk;

    initial begin
        clk = 0;
        btn_mock = 0;
        counter_test();
    end

    task counter_test();
        begin
            $monitor("Time: %0t, Clk = %d, Btn = %d,  Counter value = %d",$time, clk, btn_mock, count_value[23:0]);
            #100 btn_mock = 1;
            #101 btn_mock = 0;
            #500 $finish;
        end
    endtask

endmodule 

