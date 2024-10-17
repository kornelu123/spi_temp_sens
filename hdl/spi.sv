module spi_t
  (
    input wire sck_in,

    input wire miso,
    output reg sck_out,
    output reg mosi,
    output reg cs,

    input wire [1:0]in_bytes_count,
    input wire [1:0]out_bytes_count,

    input wire [15:0]in_bytes,
    output reg [31:0]out_bytes,

    input wire start_trans,
    output reg trans_done
  );

reg [1:0]cur_state;

reg [1:0]in_bytes_counter;
reg [1:0]out_bytes_counter;

reg [2:0]bit_count;

localparam idle         = 3'b000;
localparam trans_start  = 3'b001;
localparam trans_write  = 3'b010;
localparam trans_read   = 3'b011;
localparam trans_end    = 3'b100;

initial begin
  trans_done <= 1'b0;

  out_bytes   <= 32'h00000000;

  cs         <= 1'b1;
  mosi       <= 1'b0;
  sck_out    <= 1'b1;

  bit_count  <= 3'h7;

  in_bytes_counter    <= 2'b00;
  out_bytes_counter   <= 2'b00;
end

always @(edge start_trans) begin
  if (cur_state == idle) begin
    cur_state = trans_start;
  end
end

always @(edge sck_in) begin
  if (cur_state == trans_write || cur_state == trans_read) begin
    sck_out <= sck_in;
  end

  if (cur_state == trans_start) begin
    if(sck_in == 1'b0) begin
      cs <= 1'b0;

      in_bytes_counter  <= in_bytes_count;
      out_bytes_counter <= out_bytes_count;

      bit_count <= 3'h7;
    end else if (cs == 1'b0) begin
      cur_state = trans_write;
    end
  end

  if (cur_state == trans_write) begin
    if (sck_in == 1'b0) begin
      mosi <= in_bytes[(out_bytes_counter - 1)*8 + bit_count];

      if (bit_count == 3'b000) begin
        bit_count <= 3'h7;

        if (out_bytes_counter == 0) begin
          if (in_bytes_counter == 0) begin
            cur_state <= trans_end;
          end else begin
            cur_state <= trans_read;
          end
        end else begin
          out_bytes_counter <= out_bytes_counter - 1;
        end
      end else begin
        bit_count <= bit_count - 1;
      end
    end
  end

  if (cur_state == trans_read) begin
    if (sck_in == 1'b1) begin
      out_bytes[(in_bytes_counter - 1)*8 + bit_count] <= miso;

      if (bit_count == 3'b000) begin
        if (in_bytes_counter == 0) begin
          cur_state     <= trans_end;
          trans_done    <= 1'b1;
        end else begin
          in_bytes_counter <= in_bytes_counter - 1;
        end
      end else begin
        bit_count <= bit_count - 1;
      end
    end
  end

  if (cur_state == trans_end) begin
    cs          <= 1'b1;
    sck_out     <= 1'b1;
    cur_state   <= idle;
    trans_done  <= 1'b0;
  end
end

endmodule
