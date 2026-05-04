
library ieee;
use ieee.std_logic_1164.all;

entity tb_FIFO is
end tb_FIFO;

architecture behavior of tb_FIFO is

  -- componant used in testbench
  component FIFO
    	PORT(	aclr		: IN STD_LOGIC  := '0';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdclk		: IN STD_LOGIC ;
		rdreq		: IN STD_LOGIC ;
		wrclk		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdempty		: OUT STD_LOGIC ;
		rdusedw		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		wrfull		: OUT STD_LOGIC ;
		wrusedw		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
  end component;

  -- Signals
Signal test_aclr 	: STD_LOGIC  := '0';
Signal test_data	: STD_LOGIC_VECTOR (7 DOWNTO 0);
Signal test_rdclk	: STD_LOGIC ;
Signal test_rdreq	: STD_LOGIC ;
Signal test_wrclk	: STD_LOGIC ;
Signal test_wrreq	: STD_LOGIC ;
Signal test_q		: STD_LOGIC_VECTOR (7 DOWNTO 0);
Signal test_rdempty	: STD_LOGIC ;
Signal test_rdusedw	: STD_LOGIC_VECTOR (11 DOWNTO 0);
Signal test_wrfull	: STD_LOGIC ;
Signal test_wrusedw	: STD_LOGIC_VECTOR (11 DOWNTO 0);

  -- Clock Speed
  constant clk_period_1 : time := 8 ns;
  constant clk_period_2 : time := 8 ns;

  begin

    Comp1 : FIFO port map (
	aclr	=>test_aclr,
	data	=>test_data,	
	rdclk	=>test_rdclk,	
	rdreq	=>test_rdreq,	
	wrclk	=>test_wrclk,	
	wrreq	=>test_wrreq,	
	q	=>test_q,
	rdempty	=>test_rdempty,
	rdusedw	=>test_rdusedw,
	wrfull	=>test_wrfull,
	wrusedw	=>test_wrusedw
    );

  -- Clock generation 1 
  Clk_Generator1 : process
  begin
    test_rdclk <= '0';
    wait for clk_period_1/2;
    test_rdclk <= '1';
    wait for clk_period_1/2;
  end process;

  -- Clock generation 2 
  Clk_Generator2 : process
  begin
    test_wrclk <= '0';
    wait for clk_period_2/2;
    test_wrclk <= '1';
    wait for clk_period_2/2;
  end process;

  -- Data_Simulation
  Data_Sim : process
  begin
    	-- Start by inserting data
	wait for clk_period_1;   	
	test_aclr <= '0';
	test_data <= x"00"; -- Data_In
	test_rdreq<='0';
	test_wrreq<='0';
	wait for clk_period_1;
	test_data <= x"01"; 
	test_wrreq<='1'; --enable write into FIFO
	wait for clk_period_1;
	test_data <= x"02";
	wait for clk_period_1;
	test_data <= x"03";
	test_rdreq<='1'; -- enable reading from FIFO
	wait for clk_period_1;
	test_data <= x"04";
	wait for clk_period_1;
	test_data <= x"05";
	wait for clk_period_1;
	test_wrreq<='0';
	wait for clk_period_1*5;
	test_rdreq<='0';
    wait;
  end process;

end;




















