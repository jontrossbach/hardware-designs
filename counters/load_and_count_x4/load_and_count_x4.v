`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: New York University
// Engineer: Jon Trossbach
// 
// Create Date: 09/26/2020 03:22:59 PM
// Module Name: load_and_count_x4 
// Description: A 32-bit counter that adds 4 at each clock edge. Upon reset, the 
// counter drops to zero. When the load input is on during a clock edge a new
// 32-bit value, D, is loaded into the counter.
//////////////////////////////////////////////////////////////////////////////////


module load_and_count_x4(
    out,
    clk,
    reset,
    load,
    D
    );
    
    input wire clk, reset, load;
    input wire [31:0] D;
    
    output wire [31:0] out;
    
    reg [31:0] counter;
    
    always @(posedge clk or negedge clk or posedge reset)
      if (reset) begin
        counter <= 32'b0;
      end else if (load) begin
        counter <= D;
      end else begin
        counter <= counter + 32'd4;
      end
    
      assign out = counter;
endmodule
