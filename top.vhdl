library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
	port
	(
		clk	: in std_logic;
		rst : in std_logic;
		led : out std_logic_vector(2 downto 0)
	);
end top;

architecture behavior of top is
	--signal count: std_logic_vector(24 downto 0) := "000000000000000000000000";
	signal count: unsigned := "0";	
	signal rledout: std_logic_vector(2 downto 0) := "111";
	signal shift_cnt: std_logic_vector(1 downto 0) := "00";
	constant time: integer := 24000000;
begin

blink_process: process(clk, rst)
begin

	if (rising_edge(clk)) then

		if rst = '1' then
			count <= "0";
			rledout <= "111";
			shift_cnt <= "00";
		end if;

		if count = 24000000 then
			count <= "0";
			if shift_cnt = "10" then
				rledout <= "001";
				shift_cnt <= "00";
			else
				rledout <= rledout(1 downto 0) & "0";
				shift_cnt <= std_logic_vector( unsigned(shift_cnt) + 1 );
			end if;
		else
			count <= count + 1;
		end if;

		
	end if;

end process blink_process;

led <= rledout;

end behavior;
