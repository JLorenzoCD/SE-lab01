`timescale 1ns / 1ps

module Frequency_meter(
        input clk,
        input servo0,
        input [15:0] sw,

        output [7:0] D0_SEG,
        output [3:0] D0_AN
    );

    wire freq_in;
    assign freq_in = servo0;

    wire rst;
    assign rst = sw[0];

    logic tick_1ms;
    BaseTime1ms baseTime(
        .clk(clk),
        .rst(rst),

        .tick_out(tick_1ms)
    );

    logic cnt_en, cnt_rst, latch_en;
    FSM_Control FSM_control(
        .clk(clk),
        .rst(rst),
        .tick_1ms(tick_1ms),

        .cnt_en(cnt_en),
        .cnt_rst(cnt_rst),
        .latch_en(latch_en)
    );

    logic [15:0] Count;
    BCD_cnt_bank BCD_bank(
        .clk(clk),
        .en_cnt(cnt_en),
        .R(cnt_rst),
        .freq_in(freq_in),

        .Cout(Count)
    );

    logic [15:0] CountReg;
    register regCount(
        .clk(clk),
        .rst(rst),
        .en(latch_en),
        .d(Count),

        .q(CountReg)
    );

    logic [13:0] cnt_display;
    disp7seg_controller dispA(
        .clk(cnt_display[13]),
        .bcd_dig({ CountReg[3:0], CountReg[7:4], CountReg[11:8], CountReg[15:12] }),
        .blank_dig(4'b0000),
        .seg(D0_SEG),
        .dig_en(D0_AN)
    );
    always @(posedge clk) cnt_display <= cnt_display + 1;

endmodule
