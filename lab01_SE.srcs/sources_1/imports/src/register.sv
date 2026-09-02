`timescale 1ns / 1ps

module register(
    input logic clk,
    input logic rst,
    input logic en,

    input logic [15:0] d,

    output logic [15:0] q
    );

    always_ff @(posedge clk) begin
        if (rst) begin
            q <= 16'd0;
        end else if (en) begin
            q <= d;
        end else begin
            q <= q;
        end
    end

endmodule
