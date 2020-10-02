`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: New York University
// Engineer: Jon Trossbach
// 
// Create Date: 09/26/2020 03:22:59 PM
// Module Name: up_down_counter_tb
// Description: A 32-bit counter that adds 4 at each clock edge. Upon reset, the 
// counter drops to zero. When the load input is on during a clock edge a new
// 32-bit value, D, is loaded into the counter.
//////////////////////////////////////////////////////////////////////////////////


module load_and_count_x4_tb(
  );
  
  wire [31:0] t_out;
  reg t_clk = 0, t_reset = 0, t_load = 0;
  reg [31:0] t_D;
  
  integer i;
  
  load_and_count_x4 dut(
    .out(t_out),
    .clk(t_clk),
    .reset(t_reset),
    .load(t_load),
    .D(t_D)
  );
  
  initial begin: CLOCKBLOCK
    forever begin
      #10 t_clk <= ~t_clk;
    end
  end
    
  initial begin: TESTBLOCK
    
    //test functionality aligned with specifications
    t_reset <= 0;
    t_load <= 0;
    i=0;  
    #15 
  
    t_reset <= 1;
    #10;
  
    t_reset <= 0;
    #20;
    if (t_out[31:0]!=32'b1000) $fatal("initial clock test case failed");
       
    t_reset <= 1;
    #10; 
    if (t_out[31:0]!=32'b0) $fatal("zero reset test case failed");
    
    t_reset <= 0;    
    //for(i=1; i<=1073741823; i=i+1) begin // (2^32 -1) / 4 ~ 1073741823
    for(i=1; i<=65535; i=i+1) begin // 2^16 -1
      #10;
      if (t_out[31:0]!=(i[31:0]*4)) $fatal("enable up test case failed");
    end
    
    t_D <= 32'b1;
    t_load <= 1;
    #10
    t_load <= 0;
    //for(i=1; i<=1073741823; i=i+1) begin // (2^32 -1) / 4 ~ 1073741823
    for(i=1; i<=65535; i=i+1) begin // 2^16 -1
      #10;
      if (t_out[31:0]!=(i[31:0]*4+1)) $fatal("enable up test case failed");
    end
    
    t_D <= 32'b10;
    t_load <= 1;
    #10
    t_load <= 0;
    //for(i=1; i<=1073741823; i=i+1) begin // (2^32 -1) / 4 ~ 1073741823
    for(i=1; i<=65535; i=i+1) begin // 2^16 -1
      #10;
      if (t_out[31:0]!=(i[31:0]*4+2)) $fatal("enable up test case failed");
    end
    
    t_D <= 32'b11;
    t_load <= 1;
    #10
    t_load <= 0;
    //for(i=1; i<=1073741823; i=i+1) begin // (2^32 -1) / 4 ~ 1073741823
    for(i=1; i<=65535; i=i+1) begin // 2^16 -1
      #10;
      if (t_out[31:0]!=(i[31:0]*4+3)) $fatal("enable up test case failed");
    end
    
    //test functionality not aligned with specifications
    
    //reset left on
    t_reset <= 1;
    #20;
    if (t_out[31:0]!=32'b0) $fatal("reset left on test case failed");
    
    //load left on
    t_reset <= 0;
    t_load <= 1;
    #40
    if (t_out[31:0]!=32'b11) $fatal("load left on test case failed");
  
    $display("All tests passed");
    $finish;

  end
endmodule
