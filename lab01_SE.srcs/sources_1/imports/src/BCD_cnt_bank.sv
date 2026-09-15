`timescale 1ns / 1ps

module BCD_cnt_bank(
    input clk,
    input R,
    input en_cnt,
    input freq_in,

    output [15:0] Cout
    );

    // Señales para el detector de flanco de subida
    logic freq_in_d;
    logic freq_posedge;

    always_ff @(posedge clk) begin
        if (R) begin
            freq_in_d <= 1'b0;
        end else begin
            freq_in_d <= freq_in;
        end
    end
    // Evita contar multiples veces una misma onda larga
    assign freq_posedge = freq_in && !freq_in_d;

    // Contadores
    logic carry_cnt_U;
    logic carry_cnt_D;
    logic carry_cnt_C;

    BCD_cnt BCD_cnt_U(
        .clk(clk),
        .R(R),
        .en(en_cnt),
        .Cin(freq_posedge),

        .carry(carry_cnt_U),
        .Cout(Cout[3:0])
    );

    BCD_cnt BCD_cnt_D(
        .clk(clk),
        .R(R),
        .en(en_cnt),
        .Cin(carry_cnt_U),

        .carry(carry_cnt_D),
        .Cout(Cout[7:4])
    );

    BCD_cnt BCD_cnt_C(
        .clk(clk),
        .R(R),
        .en(en_cnt),
        .Cin(carry_cnt_D),

        .carry(carry_cnt_C),
        .Cout(Cout[11:8])
    );

    BCD_cnt BCD_cnt_M(
        .clk(clk),
        .R(R),
        .en(en_cnt),
        .Cin(carry_cnt_C),

        .carry(), // No se utiliza el carry_out
        .Cout(Cout[15:12])
    );

endmodule
