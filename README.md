# FPGA-UART PROJECT
En este repositorio usted encontrará los source para poder crear un módulo de transmisión y recepción UART con todos los módulos necesarios para su funcionamiento como podría ser el baud rate generator. A su vez se encuentra el projecto anterior [FPGA-ALU](https://github.com/JuanManuel-Cloud/FPGA-ALU) donde está el módulo ALU. La idea del proyecto es la comunicación UART entre un usuario vía PC, se le envían datos a la ALU está realiza la operación y devuelve el resultado hacia la computadora.
Para clonar el repo siga los siguientes pasos

1. ```git clone git@github.com:JuanManuel-Cloud/FPGA-UART.git```
   ```cd fpga-uart.srcs/sources_1/alu```
2. ```git submodule init```
3. ```git submodule update```

Otra alternativa es utilizar directamente el comando

```git clone --recurse-submodules git@github.com:JuanManuel-Cloud/FPGA-UART.git```