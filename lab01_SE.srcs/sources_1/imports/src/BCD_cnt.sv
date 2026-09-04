`timescale 1ns / 1ps

module BCD_cnt(
    input logic clk,
    input logic R,
    input logic en,
    input logic Cin,

    output logic carry,
    output logic [3:0] Cout
    );

    logic Cin_prev;
    logic Cin_rise;

    always_ff @(posedge clk) begin
        if (R) begin
            Cin_prev <= 1'b0;
            Cout     <= 4'd0;
        end else begin
            Cin_prev <= Cin;

            if (en && Cin && !Cin_prev) begin
                if (Cout == 4'd9)
                    Cout <= 4'd0;
                else
                    Cout <= Cout + 1'b1;
            end
        end
    end

    assign Cin_rise = Cin && !Cin_prev;
    assign carry = (Cout == 4'd9) && en && Cin_rise;

endmodule
