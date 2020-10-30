`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: New York University
// Engineer: Jon Trossbach
// 
// Create Date: 09/26/2020 03:22:59 PM
// Module Name: counter 
// Description: 5-bit counter ith "clk", and "reset" inputs. "i" is the 5 bit output:
//   - When the reset signal is high (at any point in time), the counter value
//  should be reset to 0 immediately
//////////////////////////////////////////////////////////////////////////////////


module counter(
    i,
    clk,
    reset
    );
    
    input wire clk, reset;
    
    output wire [4:0] i;
    
    reg [4:0] counter;
    
    always @(posedge clk or posedge reset)
      if (reset) begin
        counter <= 5'b0;
      end else begin
        counter <= counter + 5'b1;
      end
    
      assign i = counter;
