LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

USE std.textio.ALL;

ENTITY risv_rvTestbench IS
END risv_rvTestbench;

ARCHITECTURE testbench OF risv_rvTestbench IS
  COMPONENT riscv IS
    PORT (
      clock : IN std_logic
    );
  END COMPONENT riscv;
  SIGNAL clock : std_logic := '0';
BEGIN
  dut : riscv PORT MAP(
    clock => clock
  );

  test_process : PROCESS BEGIN
    clock <= '1';
    REPORT "TESTE FINALIZADO";
    WAIT;
  END PROCESS;
END testbench;