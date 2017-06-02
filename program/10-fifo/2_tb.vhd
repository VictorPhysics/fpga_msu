LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fifo_vitya_tb IS
END fifo_vitya_tb;

ARCHITECTURE behavior OF fifo_vitya_tb IS 

-- Component Declaration for the Unit Under Test (UUT)
component fifo

port (
CLK : in std_logic;
reset : in std_logic;
w_data : in std_logic_vector(7 downto 0);
Wr : in std_logic;
Rd : in std_logic;
r_data : out std_logic_vector(7 downto 0);
Full : out std_logic;
Empty : out std_logic
);
end component;

--Inputs
signal CLK : std_logic := '0';
signal reset : std_logic := '0';
signal w_data : std_logic_vector(7 downto 0) := (others => '0');
signal Rd : std_logic := '0';
signal Wr : std_logic := '0';

--Outputs
signal r_data : std_logic_vector(7 downto 0);
signal Empty : std_logic;
signal Full : std_logic;

-- Clock period definitions
constant CLK_period : time := 10 ns;

BEGIN

-- Instantiate the Unit Under Test (UUT)
uut: fifo
PORT MAP (
CLK => CLK,
reset => reset,
w_data => w_data,
Wr => Wr,
Rd => Rd,
r_data => r_data,
Full => Full,
Empty => Empty
);

-- Clock process definitions
CLK_process :process
begin
CLK <= '0';
wait for CLK_period/2;
CLK <= '1';
wait for CLK_period/2;
end process;

-- Reset process
reset_proc : process
begin
wait for CLK_period * 5;

reset <= '1';

wait for CLK_period * 5;

reset <= '0';

wait;
end process;

-- Write process
wr_proc : process
variable counter : unsigned (7 downto 0) := (others => '0');
begin 
wait for CLK_period * 20;

for i in 1 to 32 loop
counter := counter + 1;

w_data <= std_logic_vector(counter);

wait for CLK_period * 1;

Wr <= '1';

wait for CLK_period * 1;

Wr <= '0';
end loop;

wait for clk_period * 20;

for i in 1 to 32 loop
counter := counter + 1;

w_data <= std_logic_vector(counter);

wait for CLK_period * 1;

Wr<= '1';

wait for CLK_period * 1;

Wr <= '0';
end loop;

wait;
end process;

-- Read process
rd_proc : process
begin
wait for CLK_period * 20;

wait for CLK_period * 40;

Rd <= '1';

wait for CLK_period * 60;

Rd <= '0';

wait for CLK_period * 256 * 2;

Rd <= '1';

wait;
end process;

END;
