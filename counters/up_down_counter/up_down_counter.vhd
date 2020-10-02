----------------------------------------------------------------------------------
-- University: New York University
-- Engineer: Jon Trossbach
-- 
-- Create Date: 09/26/2020 03:22:59 PM
-- Module Name: up_down_counter 
-- Description: 16-bit counter ith "clk", "enable", "reset", and "reverse" inputs:
--   - When the enable signal is high and the reverse input is low, the counter 
--  value should increment by 1with each rising edge of the clock
--   - When the enable signal is high and the reverse input is high, the counter
--  should decrement by 1 witheach rising edge of the clock
--   - When the reset signal is high (at any point in time), the counter value
--  should be reset to 0 immediately
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity up_down_counter is
 Port (
   output: out unsigned(15 downto 0);
   clk: in std_logic;
   reverse: in std_logic;
   reset: in std_logic;
   enable: in std_logic
 );
end up_down_counter;

architecture Behavioral of up_down_counter is

signal counter: unsigned(15 downto 0) := to_unsigned(0,16);

begin

  process(clk)
  begin
    if(rising_edge(clk) or rising_edge(reset)) then
      if(reset = '1') then
        counter <= to_unsigned(0,16);
      elsif(enable = '1') then
        if(reverse <= '1') then
          counter <= counter - to_unsigned(1,16);
        else 
          counter <= counter + to_unsigned(1,16);
        end if;
      end if;
    end if;
  end process;

  output <= counter;
end Behavioral;
