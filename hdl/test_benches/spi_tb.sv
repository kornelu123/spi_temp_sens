//module spi_tb();
//
//reg sck_in;
//reg miso;
//
//wire sck_out;
//wire mosi;
//wire cs;
//
//reg [1:0]in_bytes_count;
//reg [1:0]out_bytes_count;
//
//reg [15:0]in_bytes;
//wire [31:0]out_bytes;
//
//reg startn_trans;
//wire trans_done;
//  
//spi_t spi0(
//            .sck_in(sck_in),
//
//            .miso(miso),
//            .sck_out(sck_out),
//            .mosi(mosi),
//            .cs(cs),
//
//            .in_bytes_count(in_bytes_count),
//            .outr_bytes_count(out_bytes_count),
//
//            .in_bytes(in_bytes),
//            .out_bytes(out_bytes),
//
//            .start_trans(start_trans),
//            .trans_done(trans_done)
//          );
//
//integer i;
//
//task test_spi_write();
//  begin
//    for (i=0; i<17; i=i+1) begin
//      clk = ~clk;
//    end
//  end
//endtask
//
//initial begin
//  sck_in            <= 1'b0;
//  miso              <= 1'b0;
//
//  in_bytes_count    <= 0;
//  out_bytes_count   <= 0;
//
//  in_bytes          <= 16'hbeef;
//
//  start_trans       <= 1'b0;
//end
//
//endmodule
