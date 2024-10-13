module timer (
              input wire clk_in,
              output reg sig_out
             );

parameter clk_per_s = 1000000;

localparam bit_count = $clog2(clk_per_s);
reg [bit_count-1:0]counter;

initial begin
  counter <= 0;
  sig_out <= 1'b0;
end

always @(posedge clk_in) begin
  if (counter < clk_per_s) begin
    counter = counter + 1;
  end else begin
    counter = 0;
    sig_out = ~sig_out;
  end
end

endmodule
