module SPI_register (
    input wire clk,
    input wire reset,
    input wire [24:0] in,
    output wire [24:0] out
);

reg [24:0] d_in;

always @(posedge clk) begin
    d_in <= in;
end

always @(posedge clk) begin
    if (reset) begin
        d_in <= 32'b0;
    end
end

SPI_register data_register (
    .clk(clk),
    .reset(reset),
    .d_in(d_in),
    .d_out(d_out)
);

endmodule
