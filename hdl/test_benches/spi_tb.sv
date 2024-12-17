module spi_tb();   

reg sck_in;
reg miso;

wire sck_out;
wire mosi;
wire cs;

reg [1:0]in_bytes_count;
reg [1:0]out_bytes_count;

reg [15:0]in_bytes;
wire [31:0]out_bytes;

reg start_trans;
wire trans_done;
  
spi   spi0(
            .sck_in(sck_in),

            .miso(miso),
            .sck_out(sck_out),
            .mosi(mosi),
            .cs(cs),

            .in_bytes_count(in_bytes_count),
            .out_bytes_count(out_bytes_count),

            .in_bytes(in_bytes),
            .out_bytes(out_bytes),

            .start_trans(start_trans),
            .trans_done(trans_done)
          );

integer i;

task test_spi_write();
  begin
  in_bytes_count    <= 2'b00;
  in_bytes          <= 16'hbeef;

  out_bytes_count   <= 2'b10;

  start_trans       <= 1'b1;
  for (i=0; i<50; i=i+1) begin
    #10;
    sck_in = ~sck_in;
    #10;
    sck_in = ~sck_in;
  end

  end
endtask

task test_spi_read();
  begin
  in_bytes_count    <= 2'b10;

  out_bytes_count   <= 2'b10;
  in_bytes          <= 16'hbeef;

  start_trans       <= 1'b0;
  #100;
  start_trans       <= 1'b1;
  $display("Writing some address");
  for (i=0; i<18; i=i+1) begin
    #10;
    sck_in = ~sck_in;
    #10;
    sck_in = ~sck_in;
  end
  $display("Reading from miso");

  miso              <= 1'b0;
  for (i=0; i<18; i=i+1) begin
    miso <= ~miso;
    #10;
    sck_in = ~sck_in;
    #10;
    sck_in = ~sck_in;
  end

  $display("out_bytes:%x", out_bytes);
  end
endtask

initial begin
  sck_in            <= 1'b0;
  miso              <= 1'b0;

  in_bytes_count    <= 0;
  out_bytes_count   <= 0;

  in_bytes          <= 16'hbeef;

  start_trans       <= 1'b0;

  $monitor($time, " clk_out:%b, miso:%b, mosi:%b, cs:%b, trans_done:%b", sck_out, miso, mosi, cs, trans_done);
  test_spi_write();
  test_spi_read();
end

endmodule
