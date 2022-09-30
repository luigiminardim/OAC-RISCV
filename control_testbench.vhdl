LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL; -- Imports the standard textio package.

ENTITY controlTestbench IS
END controlTestbench;

ARCHITECTURE controlTestbench OF controlTestbench IS
  COMPONENT control IS
    PORT (
      opcode : IN std_logic_vector(6 DOWNTO 0);
      alusrc : OUT std_logic;
      mem2reg : OUT std_logic;
      regwrite : OUT std_logic;
      memread : OUT std_logic;
      memwrite : OUT std_logic;
      branch : OUT std_logic
    );
  END COMPONENT;
  SIGNAL opcode : std_logic_vector(6 DOWNTO 0);
  SIGNAL alusrc : std_logic;
  SIGNAL mem2reg : std_logic;
  SIGNAL regwrite : std_logic;
  SIGNAL memread : std_logic;
  SIGNAL memwrite : std_logic;
  SIGNAL branch : std_logic;
BEGIN
  dut : control PORT MAP(
    opcode => opcode,
    alusrc => alusrc,
    mem2reg => mem2reg,
    regwrite => regwrite,
    memread => memread,
    memwrite => memwrite,
    branch => branch
  );
  PROCESS
  BEGIN
    -- Tipo R
    opcode <= "0110011";
    WAIT FOR 100 ns;
    ASSERT alusrc = '0' REPORT "Erro - Tipo R - alusrc" SEVERITY error;
    ASSERT mem2reg = '0' REPORT "Erro - Tipo R - mem2reg" SEVERITY error;
    ASSERT regwrite = '1' REPORT "Erro - Tipo R - regwrite" SEVERITY error;
    ASSERT memread = '0' REPORT "Erro - Tipo R - memread" SEVERITY error;
    ASSERT memwrite = '0' REPORT "Erro - Tipo R - memwrite" SEVERITY error;
    ASSERT branch = '0' REPORT "Erro - Tipo R - branch" SEVERITY error;
    -- Tipo LW
    opcode <= "0000011";
    WAIT FOR 100 ns;
    ASSERT alusrc = '1' REPORT "Erro - Tipo LW - alusrc" SEVERITY error;
    ASSERT mem2reg = '1' REPORT "Erro - Tipo LW - mem2reg" SEVERITY error;
    ASSERT regwrite = '1' REPORT "Erro - Tipo LW - regwrite" SEVERITY error;
    ASSERT memread = '1' REPORT "Erro - Tipo LW - memread" SEVERITY error;
    ASSERT memwrite = '0' REPORT "Erro - Tipo LW - memwrite" SEVERITY error;
    ASSERT branch = '0' REPORT "Erro - Tipo LW - branch" SEVERITY error;
    -- Tipo SW
    opcode <= "0100011";
    WAIT FOR 100 ns;
    ASSERT alusrc = '1' REPORT "Erro - Tipo SW - alusrc" SEVERITY error;
    ASSERT regwrite = '0' REPORT "Erro - Tipo SW - regwrite" SEVERITY error;
    ASSERT memread = '0' REPORT "Erro - Tipo SW - memread" SEVERITY error;
    ASSERT memwrite = '1' REPORT "Erro - Tipo SW - memwrite" SEVERITY error;
    ASSERT branch = '0' REPORT "Erro - Tipo SW - branch" SEVERITY error;
    -- Tipo BEQ
    opcode <= "1100011";
    WAIT FOR 100 ns;
    ASSERT alusrc = '0' REPORT "Erro - Tipo BEQ - alusrc" SEVERITY error;
    ASSERT regwrite = '0' REPORT "Erro - Tipo BEQ - regwrite" SEVERITY error;
    ASSERT memread = '0' REPORT "Erro - Tipo BEQ - memread" SEVERITY error;
    ASSERT memwrite = '0' REPORT "Erro - Tipo BEQ - memwrite" SEVERITY error;
    ASSERT branch = '1' REPORT "Erro - Tipo BEQ - branch" SEVERITY error;
    WAIT;

    REPORT "Teste finalizado com sucesso!" SEVERITY note;
  END PROCESS;
END controlTestbench;