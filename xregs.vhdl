LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY xregs IS
  GENERIC (WSIZE : NATURAL := 32);
  PORT (
    clk, wren : IN STD_LOGIC;
    rs1, rs2, rd : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    data : IN STD_LOGIC_VECTOR(WSIZE - 1 DOWNTO 0);
    ro1, ro2 : OUT STD_LOGIC_VECTOR(WSIZE - 1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF xregs IS
  TYPE REGS_TYPE IS ARRAY (31 DOWNTO 0) OF STD_LOGIC_VECTOR(WSIZE - 1 DOWNTO 0);
  SIGNAL regs : REGS_TYPE;
BEGIN
  ro1 <= regs(conv_integer(rs1));
  ro2 <= regs(conv_integer(rs2));
  write_process : PROCESS (clk)
  BEGIN
    IF (wren = '1' AND clk = '1') THEN
      regs(conv_integer(rd)) <= data;
      regs(0) <= 32x"0";
    END IF;
  END PROCESS;
END arch;