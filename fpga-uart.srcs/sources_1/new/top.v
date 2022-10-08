`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2022 18:17:26
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top#(
        parameter BUS_SIZE = 8,
        parameter BUS_BIT_ENABLE = 2
    )(
        input i_clk,i_reset,
        input Rx,
        output Tx
    );
    wire [BUS_SIZE - 1 : 0] data_in_reg;
    wire [BUS_SIZE - 1 : 0] data_out_reg;
    //Outputs
    wire [BUS_SIZE - 1 : 0] to_format;
    
    wire [BUS_BIT_ENABLE -1 : 0] w_enable;
    wire [BUS_SIZE - 1 : 0] to_switch;
    wire w_carry_bit;
    wire w_zero_bit;

    // Verilog code for ALU
    interfaz_alu_tx formater(
            i_clk, i_reset,
            to_format,
            w_carry_bit, w_zero_bit,
            data_out_reg
    );
    alu_top alu(
            i_clk,
            i_reset,
            w_enable,
            to_switch,  // ALU N-bit Inputs                 
            to_format, // ALU 8-bit Output
            w_carry_bit, // Carry Out Flag,
            w_zero_bit // Zero Out Flag
        );
    traductor_enable tra_en(
            i_clk,
            i_reset,
            data_in_reg,
            w_enable,
            to_switch
        );
     uart uart_unit
      (.clk(i_clk), .reset(i_reset), .rd_uart(1),
       .wr_uart(1), .rx(Rx), .w_data(data_out_reg),
       .tx_full(), .rx_empty(),
       .r_data(data_in_reg), .tx(Tx));
endmodule
