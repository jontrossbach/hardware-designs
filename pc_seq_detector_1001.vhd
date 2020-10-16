----------------------------------------------------------------------------------
-- University: New York University
-- Engineer: Jon Trossbach
-- 
-- Create Date: 10/15/2020 03:28:49 PM
-- Module Name: pc_seq_detector_1001 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

entity pc_seq_detector_1001 is
  Port ( 
    reset: in std_logic;
    clk: in std_logic;
    x1: in std_logic;
    z1: out std_logic;
    error: out bit;
    opb: out bit;
    states: out std_logic_vector(1 downto 0)
  );
end pc_seq_detector_1001;

architecture Behavioral of pc_seq_detector_1001 is

  signal state: std_logic_vector(1 downto 0) := "00";

begin

  process(clk, reset)
  
  variable odd_parity_bit: bit;
  
  begin
    if(rising_edge(clk) or rising_edge(reset)) then
      --maintain odd parity check inside D-flip flop
      odd_parity_bit := (to_bit(state(1)) xnor to_bit(state(0)));
      error <= (to_bit(state(1)) xor to_bit(state(0))) xnor odd_parity_bit;
      
      if(reset = '1') then
        state <= "00";
        z1 <= '0';
      elsif((state = "00" or state = "01" or state = "10" ) and x1 = '1') then
        state <= "01";
        z1 <= '0';
      elsif(state = "01" and x1 = '0') then
        state <= "10";
        z1 <= '0';
      elsif(state = "10" and x1 = '0') then
        state <= "11";
      elsif(state = "11" and x1 = '1') then
        state <= "01";
        z1 <= '1';
      else
        state <= "00";
        z1 <= '0';    
      end if;
      
      states <= state;
      opb <= odd_parity_bit;
      
    end if;
  end process;    
    
end Behavioral;
