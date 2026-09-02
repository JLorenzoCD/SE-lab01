`timescale 1ns / 1ps

module BaseTime1ms(
    input logic clk,       // 100MHz CLK
    input logic rst,          // Sync reset
    output logic tick_out     // 1ms Tick signal
    );

    logic [16:0] cnt;

    always_ff @(posedge clk) begin
        if (rst) begin
            cnt <= '0;
            tick_out <= 1'b0;
        end else begin
            if (cnt == 17'd99_999) begin
                cnt <= '0;
                tick_out <= 1'b1; // Emitimos el pulso de 1 ms
            end else begin
                cnt <= cnt + 1'b1;
                tick_out <= 1'b0; // Mantenemos el pulso en 0 el resto del tiempo
            end
        end
    end

endmodule



