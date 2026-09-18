# Laboratorio 1: Frecuencimentro sobre FPGA
## Introducción:
El sistema implementado es un frecuencímetro digital mediante el método de medición directa, donde para facilitar la implementación, se utiliza una ventana de tiempo de 1 segundo. Por lo cual, el conteo de los flancos ascendentes de una frecuencia equivale directamente a la frecuencia de la señal en Hertz (Hz).
La implementación fue realizada mediante el software Vivado, con el lenguaje de descripción de hardware SystemVerilog, sobre una FPGA *AMD Boolean - XC7S50CSG324A Spartan 7* prestada por la cátedra.


## Arquitectura del Diseño:
La arquitectura fue vista de forma general en la clase, la cual consta de 5 módulos descritos a continuación:

- TimeBase: Genera un tick cada 1 segundo, el cual servirá para generar la ventana de tiempo para contar los flancos ascendentes de la frecuencia. Este tick se conecta con el modulo FSM_control.
- FSM_control: Se encarga de controlar el reset y el habilitar/deshabilitar los contadores, ademas, se encarga de habilitar/deshabilitar el registro. Los outputs de este modulo se conecta con los módulos BCD_cnt_bank y Reg.
- BCD_cnt_bank: Es el modulo que contiene los 4 contadores, para la unidad, decena, centena y millares de la frecuencia. El conteo es pasado al modulo Reg.
- Reg: Se encarga de guardar el conteo de la frecuencia, para luego pasar el valor guardado a el Display_7_seg.
- Display_7_seg: Encargado de controlar 4 displays de 7 segmentos para mostrar en estos el conteo de la frecuencia.

![Esquema dada por Vivado](/informe/diseño_frecuencimetro_clases.png)
> Los módulos con fondo celeste son proporcionados por el profesor.

Eso si, al final el diseño cambio un poco, ya que por un tema de comodidad a la hora de implementar la ventana de tiempo y el display de 7 segmentos (los cuales dependen de una cierta cantidad de tiempo), el modulo #TimeBase da un **tick de 1 ms** en vez de un tick de 1 segundo. Luego para obtener los tiempos necesarios, simplemente se realizo un contador de ticks de 1 ms. La siguiente imagen muestra el diagrama obtenido al implementar el frecuencimetro en Vivado.

![Esquema dada por Vivado](/informe/schematic.jpg)
> Se puede notar que no hay grandes diferencias con el diseño pensado en clases, salvo un contador que le pasa el tiempo deseado al display de 7 segmentos.

Decisiones de diseño:
1. La base de tiempo es de 1ms en vez de 1s. Los tiempos necesitados son obtenidos mediante el conteo del tick de 1 ms.
2. No hay aviso en caso de overflow de los contadores.
3. A ultimo momento decidí modificar el diseño del BCD_cnt_bank para evitar contar multiple veces una frecuencia que sea de onda larga. Esto se realizo guardando un estado previo de la frecuencia de entrada, como se ve en el siguiente código:

    ```v
    `timescale 1ns / 1ps

    module BCD_cnt_bank
        // ...

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

        // ...
    endmodule
    ```


## Resultados y Síntesis
![Esquema dada por Vivado](/informe/utilization_report.png)


## Conclusion



<!--

Inlcuir una breve explicacion de la Unidad de Control junto a su Diagrama de Estados (implementacion de la FSM)

4. Resultados y Síntesis: Evidencia breve de que funcionó en la placa (por ejemplo, qué frecuencias de prueba inyectaron y qué observaron en los displays) y una tabla pequeña extraída del Utilization Report de Vivado indicando cuántos LUTs (Look-Up Tables) y Flip-Flops consumió el diseño. Esto los introduce al concepto de "costo espacial" de un algoritmo en hardware.

5. Conclusión (Elaboracion personal!! NO-IA: Un pequeño parrafo con una reflexión técnica sobre el desafío de cambiar el paradigma de programación: pasar de un flujo de ejecución línea por línea (software) a la instanciación de bloques que se ejecutan en paralelo de manera concurrente (hardware).

-->