
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity fifo_av is
  Port ( 
  clk,reset: in std_logic;
  nav: std_logic_vector (3 downto 0);
  ready: std_logic;
  dv_in:in std_logic;
  dv_out: out std_logic;
  d_in: in std_logic_vector (17 downto 0);
  d_out: out std_logic_vector (17 downto 0));
  
end fifo_av;

architecture Behavioral of fifo_av is
COMPONENT fifo_generator_0
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
    full : OUT STD_LOGIC;
    overflow : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    underflow : OUT STD_LOGIC
  );
END COMPONENT;
type state_type is (waiting_fst, counting_fst, unloading);
signal state_reg, state_next:state_type;
signal cnt_reg,cnt_next:std_logic_vector (3 downto 0);
signal nav_reg,nav_next:std_logic_vector (3 downto 0);
--signal sh_reg, sh_next,sh1_reg,sh1_next,sh2_reg,sh2_next: std_logic_vector (17 downto 0);
signal d_reg: std_logic_vector (17 downto 0);
--signal b_reg,b_next: std_logic_vector (2 downto 0);
signal q_reg,q_next: std_logic;
signal dv_reg, dv_in_reg: std_logic;
signal clka :  STD_LOGIC;
signal rst :  STD_LOGIC;
signal din :  STD_LOGIC_VECTOR(17 DOWNTO 0);
signal wr_en, wr_en_reg :  STD_LOGIC;
signal rd_en, rd_en_reg :  STD_LOGIC;
signal dout :  STD_LOGIC_VECTOR(17 DOWNTO 0);
signal full :  STD_LOGIC;
signal overflow :  STD_LOGIC;
signal empty :  STD_LOGIC;
signal valid :  STD_LOGIC;
signal underflow :  STD_LOGIC;
begin

fifo : fifo_generator_0
  PORT MAP (
    clk => clka,
    rst => rst,
    din => din,
    wr_en => wr_en,
    rd_en => rd_en,
    dout => dout,
    full => full,
    overflow => overflow,
    empty => empty,
    valid => valid,
    underflow => underflow
  );
clka<=clk;
process (clk,reset)
    begin
    if (reset='1') then
        state_reg<=waiting_fst;
        cnt_reg<="1111";
        nav_reg<=nav;
        q_reg<='0';
--        sh_reg<=(others=>'0');
--        sh1_reg<=(others=>'0');
--        sh2_reg<=(others=>'0');
--        b_reg<="000";
    elsif (rising_edge(clk)) then
        state_reg<=state_next;
        cnt_reg<=cnt_next;
        nav_reg<=nav_next;
        d_reg<=dout;
        dv_reg<=valid;
--        sh_reg<=sh_next;
--        b_reg<=b_next;
        q_reg<=q_next;
        rd_en_reg<=rd_en;
--        wr_en<=wr_en_reg;
--        sh1_reg<=sh1_next;
--        sh2_reg<=sh2_next;
    end if;
end process;
--next state logic


process(state_reg,ready,cnt_reg,q_reg,nav_reg,d_reg,d_in,dv_in,dout)
begin
    state_next<=state_reg;
    cnt_next<=cnt_reg;
--    sh_next<=sh_reg;
    nav_next<=nav_reg;
--    sh1_next<=sh1_reg;
--    sh2_next<=sh2_reg;
--    b_next<=b_reg(1 downto 0)&dv_in;
    dv_out<='0';
    d_out<=(others=>'0');
    rd_en<='0';
    case state_reg is
        when waiting_fst=>
            if (dv_in='1') then
                wr_en<='1';
                din<=d_in;
                cnt_next<=cnt_reg-1;
            else
                wr_en<='0';
            end if;
            if (cnt_reg="0000") then
                nav_next<=nav_reg-1;
                cnt_next<="1111";
                state_next<=counting_fst;
                rd_en<='1';
            end if;
        when counting_fst =>
--            sh_next<=d_in;
--            sh1_next<=sh_reg;
--            sh2_next<=sh1_reg;
--            b_next(0)<=dv_in;
            
            if (dv_in='1') then
                wr_en<='1';
                rd_en<=dv_in;
                din<=dout+d_in;
                cnt_next<=cnt_reg-1;
            else
                wr_en<='0';
                rd_en<=dv_in;
            end if;
            if (cnt_reg="0000") then
                cnt_next<="1111";
--                rd_en<='0';
                nav_next<=nav_reg-1;
            end if;
            if (nav_reg="0000") then
                state_next<=unloading;
            end if;
        when unloading =>
            rd_en<='1';
            if (ready='1') then
                rd_en<='1';
                d_out<=d_reg;
                dv_out<=dv_reg;
            else
                rd_en<='0';
--                q_next<='0';
            end if;
--            if (q_reg='1') then
--                rd_en<='1';
--                d_out<=d_reg;
--                dv_out<=dv_reg;
--            end if;
            if (underflow='1') then
                state_next<=waiting_fst;
            end if;
    end case;
 end process;

end Behavioral;
