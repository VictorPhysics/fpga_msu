
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity fifo_av_tb is
--  Port ( );
end fifo_av_tb;

architecture Behavioral of fifo_av_tb is
signal clk,reset,ready,dv_in,dv_out: std_logic;
signal nav: std_logic_vector (3 downto 0);
signal d_in,d_out: std_logic_vector (17 downto 0);
begin
 dut: entity work.fifo_av (Behavioral)
 port map (
     clk=>clk,
     reset=>reset,
     ready=>ready,
     dv_in=>dv_in,
     dv_out=>dv_out,
     nav=>nav,
     d_in=>d_in,
     d_out=>d_out
     );
 process
 begin
     clk<='0';
     wait for 5 ns;
     clk<='1';
     wait for 5 ns;
 end process;
 
 process
 begin
     reset<='1';
     dv_in<='0';
     d_in<=(others=>'0');
     ready<='0';
     nav<="0011";
     wait for 115 ns;
     reset<='0';
     for i in 0 to 15 loop
         d_in<= std_logic_vector (to_signed(i+10,18));
         dv_in<='1';
         wait for 10 ns;
         end loop;
         dv_in<='0';
         wait for 50 ns;
     for i in 0 to 31 loop
         d_in<= std_logic_vector (to_signed(i,18));
         dv_in<=not dv_in;
         wait for 10 ns;
     end loop;
     dv_in<='0';
     wait for 50 ns;
     for i in 0 to 15 loop
          d_in<= std_logic_vector (to_signed(i,18));
          dv_in<='1';
          wait for 10 ns;
      end loop;
      dv_in<='0';
      wait for 100 ns;
     ready<='1';
     wait for 170 ns;
     ready<='0';
     wait;
 end process;
end Behavioral;
