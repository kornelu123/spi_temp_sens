module presc(
              input wire clk_in,
              output reg clk_out
            );

parameter value = 128;

localparam bit_count = $clog2(value);

reg [bit_count-1:0]count;

initial begin
  count = 0;
  clk_out <= 1'b0;
end

always @(edge clk_in) begin
  if(count == (value - 1)) begin
    count = 0;
    clk_out = ~clk_out;
  end else begin
    count = count + 1;
  end
end

endmodule
