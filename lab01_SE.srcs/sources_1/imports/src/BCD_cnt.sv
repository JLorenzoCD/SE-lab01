`timescale 1ns / 1ps

module BCD_cnt(
    input logic clk,
    input logic R,
    input logic en,
    input logic Cin,

    output logic carry,
    output logic [3:0] Cout
    );

    always_ff @(posedge clk) begin
        if (R) begin
            Cout <= 4'd0;
        end else if (en && Cin) begin
            if (Cout == 4'd9) begin
                Cout <= 4'd0;
            end else begin
                Cout <= Cout + 1'b1;
            end
        end
    end

    assign carry = (Cout == 4'd9) && en && Cin;

endmodule
