`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: New York University
// Engineer: Jon Trossbach
// 
// Create Date: 09/26/2020 03:22:59 PM
// Module Name: up_down_counter 
// Description: 16-bit counter ith "clk", "enable", "reset", and "reverse" inputs:
//   - When the enable signal is high and the reverse input is low, the counter 
//  value should increment by 1with each rising edge of the clock
//   - When the enable signal is high and the reverse input is high, the counter
//  should decrement by 1 witheach rising edge of the clock
//   - When the reset signal is high (at any point in time), the counter value
//  should be reset to 0 immediately
//////////////////////////////////////////////////////////////////////////////////


module up_down_counter(
    out,
    clk,
    reverse,
    reset,
    enable
    );
    
    input wire clk, reverse, reset, enable;
    
    output wire [15:0] out;
    
    reg [15:0] counter;
    
    always @(posedge clk or posedge reset)
      if (reset) begin
        counter <= 16'b0;
      end else
        if (enable) begin
          if (reverse) begin
            counter <= counter - 16'd1;
          end else begin
            counter <= counter + 16'd1;
          end
      end 
    
      assign out = counter;
    
endmodule
