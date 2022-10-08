`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2022 18:43:24
// Design Name: 
// Module Name: top_tb
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


module top_tb(
        input i_clk,i_reset,
        input [7:0]Tx_data,
        output [7:0]Rx_data
    );
    wire Rx_serial;
    wire Tx_serial;
    
    top fpga(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .Rx(Tx_serial),
        .Tx(Rx_serial)
    );
    uart transmisor
      (.clk(i_clk), .reset(i_reset), .rd_uart(1),
       .wr_uart(1), .rx(Rx), .w_data(Tx_data),
       .tx_full(), .rx_empty(),
       .r_data(), .tx(Tx_serial));
    uart receptor
      (.clk(i_clk), .reset(i_reset), .rd_uart(1),
       .wr_uart(1), .rx(Rx_serial), .w_data(),
       .tx_full(), .rx_empty(),
       .r_data(Rx_data), .tx());
           
   
endmodule
