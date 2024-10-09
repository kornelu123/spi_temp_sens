module SPI_register (
    input wire new_data,
    input wire [23:0] in,
    output reg [15:0] out
);

reg [15:0] d_in;
integer i, temp;

initial begin
    i <= 1'b0;
    out <= 16'b0;
end

always @(posedge new_data) begin
    d_in <= in[23:8];
    temp = d_in;
    out[3:0] = temp%10;
    temp = temp/10;
    out[7:4] = temp%10;
    temp = temp/10;
    out[11:8] = temp%10;
    temp = temp/10;
    out[15:12] = temp%10;
end



endmodule

