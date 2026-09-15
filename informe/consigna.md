[ENTREGABLE] Laboratorio 1: Frecuencimentro sobre FPGA

Estructura del Informe de Laboratorio (Máx. 3 páginas)
1. Introducción:
Descripción muy breve del sistema implementado (Frecuencímetro digital mediante el método de medición directa) con mención de la plataforma de hardware (FPGA Boolean Board) y el lenguaje utilizado (SystemVerilog).

2. Arquitectura del Diseño:
Debe contener un Diagrama de Bloques (puede ser un esquema simple o una captura de RTL de Vivado) que muestre la interconexión de la Base de Tiempo, los Contadores BCD, la Unidad de Control (FSM) y los registros. Ademas de una breve explicacion de las Decisiones de Diseño adoptadas. Inlcuir una breve explicacion de la Unidad de Control junto a su Diagrama de Estados (implementacion de la FSM)

4. Resultados y Síntesis: Evidencia breve de que funcionó en la placa (por ejemplo, qué frecuencias de prueba inyectaron y qué observaron en los displays) y una tabla pequeña extraída del Utilization Report de Vivado indicando cuántos LUTs (Look-Up Tables) y Flip-Flops consumió el diseño. Esto los introduce al concepto de "costo espacial" de un algoritmo en hardware.

5. Conclusión (Elaboracion personal!! NO-IA: Un pequeño parrafo con una reflexión técnica sobre el desafío de cambiar el paradigma de programación: pasar de un flujo de ejecución línea por línea (software) a la instanciación de bloques que se ejecutan en paralelo de manera concurrente (hardware).

---

### FPGA
POSIBLE A UTILIZAR: xc7s50csga324-1 (AMD Boolean - XC7S50CSG324A Spartan 7)
ACTIVO: xc7s6ftgb196-1
