`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2022 20:33:53
// Design Name: 
// Module Name: traductor_enable
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


module traductor_enable
      #(
    parameter BUS_ENABLE=2, // number of bits in counter
              BUS_DATA=8 // mod-BUS_DATA
   )
   (
    input wire clk, reset,i_empty,
    input wire [BUS_DATA-1:0] i_data,
    output wire [BUS_ENABLE-1:0] o_en,
    output wire [BUS_DATA-1:0] o_data,
    output wire o_rd
   );

   //signal declaration
   reg [BUS_ENABLE-1:0] r_enable;
   reg [BUS_DATA-1:0] r_data;
   reg [BUS_ENABLE-1:0] r_enable_next;
   reg [BUS_DATA-1:0] r_data_next;
   
   reg rd_reg;

   // body
   // register
   always @(posedge clk)
      if (reset)
      begin
         r_enable <= 3'd0;
         r_data <= 8'd0;
         rd_reg <= 1'd0;
      end
      else
        if(~i_empty)
        begin
             rd_reg <= 1'd1;
             r_enable <= r_enable_next;
             r_data <= r_data_next;
        end
        else
             rd_reg <= 1'd0;

   // next-state logic
   always @(*)  
    begin    
        if(i_data=="A")     
            r_enable_next = #(BUS_ENABLE)'d0;       
        else if(i_data=="B")
            r_enable_next = #(BUS_ENABLE)'d1;
        else if(i_data=="O")      
            r_enable_next = #(BUS_ENABLE)'d2;      
            
        r_data_next = i_data; 
   end

   assign o_data = r_data;
   assign o_en = r_enable;
   assign o_rd = rd_reg;
endmodule
