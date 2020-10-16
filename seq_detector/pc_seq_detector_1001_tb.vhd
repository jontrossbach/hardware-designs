----------------------------------------------------------------------------------
-- University: New York University
-- Engineer: Jon Trossbach
-- 
-- Create Date: 10/15/2020 06:00:16 PM
-- Module Name: pc_seq_detector_1001_tb - Behavioral
-- Description: 1.13 Design a parity-checked Mealy synchronous sequential machine
-- that generates an output z 1 whenever the sequence 1001 is detected on a serial
-- data input line x 1 . Overlapping sequences are valid. Output z 1 is asserted
-- at time t 2 and deasserted at t 3 . The parity flip-flop maintains odd parity
-- over the state flipflops and the parity flip-flop itself. Use built-in
-- primitives for the next-state logic and the output logic. Use D flip-flops
-- as the storage elements. Obtain the structural design module, the test bench
-- module, the outputs, and the waveforms.
---> 1.15 Design a parity-checked Mealy synchronous sequential machine that
-- generates an output z 1 whenever the sequence 1001 is detected on a serial
-- data input line x 1 . Overlapping sequences are valid. Output z 1 is asserted
-- at time t 2 and deasserted at t 3 . The parity flip-flop maintains odd parity
-- over the state flipflops and the parity flip-flop itself. This problem repeats
-- Problem 3.13, but uses behavioral modeling. Obtain the structural design module,
-- the test bench module, the outputs, and the waveforms.
-- Cavanagh, Joseph. Sequential Logic and Verilog HDL Fundamentals, Taylor &
-- Francis Group, 2015. ProQuest Ebook Central,
-- http://ebookcentral.proquest.com/lib/nyulibrary-ebooks/detail.action?docID=4744382.
-- Created from nyulibrary-ebooks on 2020-10-08 20:31:57.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;

entity pc_seq_detector_1001_tb is
--  Port ( );
end pc_seq_detector_1001_tb;

architecture Behavioral of pc_seq_detector_1001_tb is
  signal t_reset : std_logic := '0';
  signal t_clk : std_logic := '0';
  signal t_x1 : std_logic := '0';
  signal t_z1 : std_logic := '0';
  signal t_error : bit := '0';
  signal t_opb : bit := '0';
  signal t_states : std_logic_vector(1 downto 0) := "00";
  
  constant CLK_PERIOD : TIME := 20ns;

begin

  TestDetector : entity work.pc_seq_detector_1001 port map (
    reset => t_reset,
    clk => t_clk,
    x1 => t_x1,
    z1 => t_z1,
    error => t_error,
    states => t_states,
    opb => t_opb
  );
  
  gen_clock : process
  begin

    wait for (CLK_PERIOD/2);
    t_clk <= not t_clk;

  end process;
  
  test_behaviour : process
    begin
  
    t_reset <= '0'; 
    wait for CLK_PERIOD/4; 
    wait for CLK_PERIOD/2;
    
    t_reset <= '1';
    wait for CLK_PERIOD/2;
                                                                                               
    assert(t_z1 = '0') report "initial reset test case failed" severity error;
    t_reset <= '0';
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    --t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    assert(t_z1 = '1') report "correct sequence not detected" severity error;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    --t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    assert(t_z1 = '1') report "correct overlapping sequence not detected" severity error;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    --t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    assert(t_z1 = '1') report "sequence does not detect 11001 correctly" severity error;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    --t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    assert(t_z1 = '1') report "sequence does not detect 101001 correctly" severity error;

    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    t_x1 <= '0';
    wait for CLK_PERIOD;
    
    --t_x1 <= '0';
    wait for CLK_PERIOD;
    
    t_x1 <= '1';
    wait for CLK_PERIOD;
    
    assert(t_z1 = '1') report "sequence does not detect 10001001 correctly" severity error;
    
    finish;
  
  end process;

end Behavioral;
