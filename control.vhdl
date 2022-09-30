LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control IS
  PORT (
    opcode : IN std_logic_vector(6 DOWNTO 0);
    SIGNAL alusrc : OUT std_logic;
    SIGNAL mem2reg : OUT std_logic;
    SIGNAL regwrite : OUT std_logic;
    SIGNAL memread : OUT std_logic;
    SIGNAL memwrite : OUT std_logic;
    SIGNAL branch : OUT std_logic
  );
END ENTITY;

ARCHITECTURE rtl OF control IS
  TYPE instruction_category_type IS (r_category, lw_category, sw_category, beq_category);

  SIGNAL instruction_category : instruction_category_type;
BEGIN
  instruction_category <= r_category WHEN opcode = "0110011" ELSE
    lw_category WHEN opcode = "0000011" ELSE
    sw_category WHEN opcode = "0100011" ELSE
    beq_category WHEN opcode = "1100011";

  alusrc <= '1' WHEN instruction_category = lw_category OR instruction_category = sw_category ELSE '0';
  mem2reg <= '1' WHEN instruction_category = lw_category ELSE '0';
  regwrite <= '1' WHEN instruction_category = r_category OR instruction_category = lw_category ELSE '0';
  memread <= '1' WHEN instruction_category = lw_category ELSE '0';
  memwrite <= '1' WHEN instruction_category = sw_category ELSE '0';
  branch <= '1' WHEN instruction_category = beq_category ELSE '0';
END ARCHITECTURE;