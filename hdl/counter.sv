module counter(
    input wire clk,
    input wire rst,
    output reg [23:0] count
    );

    initial begin
        count[23:0] <= 24'h100;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 24'h100; // Reset count to 0
        end else if (count == 24'd999900) begin
            count <= 24'h100;
        end else begin
            count <= count + 1; // Increment count
        end
    end

endmodule

