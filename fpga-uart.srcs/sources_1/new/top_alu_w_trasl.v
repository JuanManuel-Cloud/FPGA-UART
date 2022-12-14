`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2022 20:58:05
// Design Name: 
// Module Name: top_alu_w_trasl
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


module top_alu_w_trasl#(
        parameter BUS_OP_SIZE = 6,
        parameter BUS_SIZE = 8,
        parameter BUS_BIT_ENABLE = 2
    )(
        input i_clk,i_reset,
        input [BUS_SIZE - 1 : 0] i_data,
        output [BUS_SIZE - 1 : 0] o_led
    );

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
            o_led
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
            i_data,
            w_enable,
            to_switch
        );
endmodule
