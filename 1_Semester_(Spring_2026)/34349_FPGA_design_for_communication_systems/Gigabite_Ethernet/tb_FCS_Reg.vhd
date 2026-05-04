
library ieee;
use ieee.std_logic_1164.all;

entity tb_FCS_Reg is
end tb_FCS_Reg;

architecture behavior of tb_FCS_Reg is

  -- componant used in testbench
  component FCS_Reg
    	port(
	Reset			: in std_logic;
    	Rx_Clk        		: in std_logic;
	Rx_Valid		: in std_logic;
	RX_Data   		: in std_logic_vector(7 downto 0);
	FCS_Check		: in std_logic;
	fcs_error		: out std_logic 

	);
  end component;

  -- Signals
	Signal test_Reset	: std_logic;
	Signal test_Rx_Clk	: std_logic;
	Signal test_Rx_Valid	: std_logic;
	Signal test_RX_Data	: std_logic_vector(7 downto 0);
	Signal test_FCS_Check	: std_logic;
	Signal test_fcs_error	: std_logic; 

 -- constants
	constant Preamble 	: std_logic_vector(55 downto 0) := x"AAAAAAAAAAAAAA";
	constant Start_of_Frame : std_logic_vector(7 downto 0)  := x"AB";	
	constant Destination_MAC: std_logic_vector(48 downto 0) := x"000000000002";
	constant Source_MAC	: std_logic_vector(48 downto 0) := x"000000000001";
  -- Clock Speed
  constant clk_period_1 : time := 8 ns;

  begin

    Comp1 : FCS_Reg port map (
	Reset		=>test_Reset,
	Rx_Clk		=>test_Rx_Clk,	
	Rx_Valid	=>test_Rx_Valid,	
	RX_Data		=>test_RX_Data,	
	FCS_Check	=>test_FCS_Check,	
	fcs_error	=>test_fcs_error	
    );

  -- Clock generation 1 
  Clk_Generator1 : process
  begin
    test_Rx_Clk <= '0';
    wait for clk_period_1/2;
    test_Rx_Clk <= '1';
    wait for clk_period_1/2;
  end process;

  -- Data_Simulation
  Data_Sim : process
  begin
    	-- Start by inserting data
	wait for clk_period_1;   	
	test_Reset	<= '1';
	test_Rx_Valid	<= '0';
	test_RX_Data	<= x"00";
	test_FCS_Check	<= '0';
	wait for clk_period_1; 
	test_Reset<= '0';
	wait for clk_period_1;
	

		



	-- send the first 













    wait;
  end process;

end;

























