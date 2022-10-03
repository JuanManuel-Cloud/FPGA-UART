// Listing 4.21
`timescale 1ns / 1ps

module fifo_test
   (
    
   );
    localparam BITS = 8;
   
   reg [BITS-1:0] sw_reg;
   reg [1:0] btn_reg;
   reg clk;
   reg reset;
   wire [BITS-1:0] led;
   wire empty;
   wire full;

   
   assign sw = sw_reg;
   assign btn = btn_reg;
   
   fifo #(.B(BITS), .W(3)) fifo_unit
      (.clk(clk), .reset(reset),
      .rd(btn_reg[0]), .wr(btn_reg[1]), .w_data(sw_reg),
      .r_data(led), .full(full), .empty(empty));
      
   integer i;
   initial begin
        clk = 1;
        reset = 1;
        #1
        reset = 0;
        sw_reg = 8'b11111111; // 255 representado en hexa de N bits
        btn_reg = 2'b10;
        for(i=0;i <2**fifo_unit.W; i=i+1)
        begin
            #2
            sw_reg = sw_reg-1; // 255 representado en hexa de N bits
        end
        btn_reg = 2'b01;
        #12
        $finish;
   end
    
    always begin
        #1
        clk = ~clk;
    end
endmodule
