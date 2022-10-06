LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY aluControl IS
  PORT (
    instruction : IN std_logic_vector(31 DOWNTO 0);
    aluOp : OUT std_logic_vector(3 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE rtl OF aluControl IS
BEGIN
  aluOp <= "0000";
END ARCHITECTURE;