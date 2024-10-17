module top(
  input btn_0,
  input wire sys_clk_pin,

  output led_0,
  output phy_sck
);

timer     tim0
          (
            .clk_in(sys_clk_pin),
            .sig_out(led_0)
          );

endmodule
