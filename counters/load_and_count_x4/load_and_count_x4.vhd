----------------------------------------------------------------------------------
-- University: New York University
-- Engineer: Jon Trossbach
-- 
-- Create Date: 09/26/2020 03:22:59 PM
-- Module Name: load_and_count_x4 
-- Description: A 32-bit counter that adds 4 at each clock edge. Upon reset, the 
-- counter drops to zero. When the load input is on during a clock edge a new
-- 32-bit value, D, is loaded into the counter.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity load_and_count_x4 is
 Port (
   output: out unsigned(31 downto 0);
   clk: in std_logic;
   reset: in std_logic;
   load: in std_logic;
   D: in unsigned(31 downto 0)
 );
end load_and_count_x4;

architecture Behavioral of load_and_count_x4 is

signal counter: unsigned(31 downto 0) := to_unsigned(0,32);

begin

  process(clk)
  begin
    if(rising_edge(clk) or falling_edge(clk) or rising_edge(reset)) then
      if(reset = '1') then
        counter <= to_unsigned(0,32);
      elsif(load = '1') then
        counter <= D;
      else 
        counter <= counter + to_unsigned(4,32);
      end if;
    end if;
  end process;

  output <= counter;
end Behavioral;
