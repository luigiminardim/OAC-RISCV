LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY riscv IS
  PORT (
    clock : IN std_logic
  );
END ENTITY riscv;

ARCHITECTURE arch OF riscv IS
  COMPONENT rom_rv IS
    PORT (
      address : IN std_logic_vector;
      dataout : OUT std_logic_vector
    );
  END COMPONENT rom_rv;

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

  COMPONENT xregs IS
    PORT (
      clk, wren : IN std_logic;
      rs1, rs2, rd : IN std_logic_vector(4 DOWNTO 0);
      data : IN std_logic_vector(32 - 1 DOWNTO 0);
      ro1, ro2 : OUT std_logic_vector(32 - 1 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT genImm32 IS
    PORT (
      instr : IN std_logic_vector(31 DOWNTO 0);
      imm32 : OUT signed(31 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT aluControl IS
    PORT (
      instruction : IN std_logic_vector(31 DOWNTO 0);
      aluOp : OUT std_logic_vector(3 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT ulaRV IS
    PORT (
      opcode : IN std_logic_vector(3 DOWNTO 0);
      a, b : IN std_logic_vector(31 DOWNTO 0);
      z : OUT std_logic_vector(31 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT ram_rv IS
    PORT (
      clock : IN std_logic;
      we : IN std_logic;
      address : IN std_logic_vector;
      datain : IN std_logic_vector;
      dataout : OUT std_logic_vector
    );
  END COMPONENT ram_rv;

  SIGNAL pc : std_logic_vector(7 DOWNTO 0) := 8x"00";
  SIGNAL instruction : std_logic_vector(31 DOWNTO 0);
  SIGNAL opcode : std_logic_vector(6 DOWNTO 0);
  SIGNAL rs1 : std_logic_vector(4 DOWNTO 0);
  SIGNAL rs2 : std_logic_vector(4 DOWNTO 0);
  SIGNAL rd : std_logic_vector(4 DOWNTO 0);
  SIGNAL alusrc : std_logic;
  SIGNAL mem2reg : std_logic;
  SIGNAL regwrite : std_logic;
  SIGNAL memread : std_logic;
  SIGNAL memwrite : std_logic;
  SIGNAL branch : std_logic;
  SIGNAL rd_data : std_logic_vector(32 - 1 DOWNTO 0);
  SIGNAL rs1_data : std_logic_vector(32 - 1 DOWNTO 0);
  SIGNAL rs2_data : std_logic_vector(32 - 1 DOWNTO 0);
  SIGNAL imm32 : signed(31 DOWNTO 0);
  SIGNAL aluOp : std_logic_vector(3 DOWNTO 0);
  SIGNAL ulaInput2 : std_logic_vector(31 DOWNTO 0);
  SIGNAL aluResult : std_logic_vector(31 DOWNTO 0);
  SIGNAL zero : std_logic;
  signal ramAddress : std_logic_vector(7 DOWNTO 0);
  SIGNAL mem_data : std_logic_vector(32 - 1 DOWNTO 0);
BEGIN
  instruction_mem : rom_rv PORT MAP(
    address => pc,
    dataout => instruction
  );
  opcode <= instruction(6 DOWNTO 0);
  rs1 <= instruction(11 DOWNTO 7);
  rs2 <= instruction(19 DOWNTO 15);
  rd <= instruction(24 DOWNTO 20);

  control_component : control PORT MAP(
    opcode => opcode,
    alusrc => alusrc,
    mem2reg => mem2reg,
    regwrite => regwrite,
    memread => memread,
    memwrite => memwrite,
    branch => branch
  );

  xregs_component : xregs PORT MAP(
    clk => clock,
    wren => regwrite,
    rs1 => rs1,
    rs2 => rs2,
    rd => rd,
    data => rd_data,
    ro1 => rs1_data,
    ro2 => rs2_data
  );

  genImm32_component : genImm32 PORT MAP(
    instr => instruction,
    imm32 => imm32
  );

  aluControl_component : aluControl PORT MAP(
    instruction => instruction,
    aluOp => aluOp
  );

  ulaInput2 <=
    std_logic_vector(imm32) WHEN alusrc = '1'
    ELSE rs2_data;

  ulaRV_component : ulaRV PORT MAP(
    opcode => aluOP,
    a => rs1_data,
    b => ulaInput2,
    z => aluResult
  );
  zero <= aluResult(0);

  ramAddress <= aluResult(7 DOWNTO 0);
  data_mem : ram_rv PORT MAP(
    clock => clock,
    we => memwrite,
    address => ramAddress,
    datain => rs2_data,
    dataout => mem_data
  );

  rd_data <=
    aluResult WHEN mem2reg = '0'
    ELSE mem_data WHEN mem2reg = '1';

  change_pc : PROCESS (clock) BEGIN
    IF clock = '1' THEN
      pc <= std_logic_vector(signed(pc) + 4);
    END IF;
  END PROCESS;
END ARCHITECTURE;