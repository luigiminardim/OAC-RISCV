LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY genImm32 IS
  PORT (
    instr : IN std_logic_vector(31 DOWNTO 0);
    imm32 : OUT signed(31 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF genImm32 IS
  TYPE FORMAT_RV IS (R_type, I_type, S_type, SB_type, UJ_type, U_type);
  SIGNAL imm_r, imm_i, imm_s, imm_sb, imm_uj, imm_u : signed(31 DOWNTO 0);
  SIGNAL opcode : std_logic_vector(6 DOWNTO 0);
  SIGNAL format : FORMAT_RV;
BEGIN
  imm_r <= X"00000000";
  imm_i <= resize(signed(instr(31 DOWNTO 20)), 32);
  imm_s <= resize(signed(instr(31 DOWNTO 25) & instr(11 DOWNTO 7)), 32);
  imm_sb <=
    resize(signed(instr(31) & instr(7) & instr(30 DOWNTO 25) & instr(11 DOWNTO 8)), 31) & '0';
  imm_uj <=
    resize(signed(instr(31) & instr(19 DOWNTO 12) & instr(20) & instr(30 DOWNTO 21) & '0'), 32);
  imm_u <= signed(instr(31 DOWNTO 12)) & X"000";
  opcode <= instr(6 DOWNTO 0);
  format <=
    R_type WHEN opcode = 7X"33" ELSE
    I_type WHEN opcode = 7X"03" OR opcode = 7X"13" OR opcode = 7X"67" ELSE
    S_type WHEN opcode = 7X"023" ELSE
    SB_type WHEN opcode = 7X"63" ELSE
    UJ_type WHEN opcode = 7X"6F" ELSE
    U_type WHEN opcode = 7X"37";
  imm32 <=
    imm_r WHEN format = R_type ELSE
    imm_i WHEN format = I_type ELSE
    imm_s WHEN format = S_type ELSE
    imm_sb WHEN format = SB_type ELSE
    imm_uj WHEN format = UJ_type ELSE
    imm_u WHEN format = U_type;
END arch;