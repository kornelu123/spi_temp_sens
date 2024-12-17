module presc(
              input wire clk_in_p,
              output reg clk_out_p
            );

parameter value = 65535;

localparam bit_count = $clog2(value);

reg [bit_count:0]count;

initial begin
  count       <= 0;
  clk_out_p   <= 1'b0;
end

always @(posedge clk_in_p) begin
  if(count < (value/2)) begin
    count = count + 1;
  end else begin
    count = 0;
    clk_out_p = ~clk_out_p;
  end
end

endmodule
