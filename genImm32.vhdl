library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity genImm32 is
  port (
    instr : in std_logic_vector(31 downto 0);
    imm32 : out signed(31 downto 0)
  );
end entity;

architecture arch of genImm32 is
  type FORMAT_RV is (R_type, I_type, S_type, SB_type, UJ_type, U_type);
  signal imm_r, imm_i, imm_s, imm_sb, imm_uj, imm_u : signed(31 downto 0);
  signal opcode : std_logic_vector(6 downto 0);
  signal format : FORMAT_RV;
begin
  imm_r <= X"00000000";
  imm_i <= resize(signed(instr(31 downto 20)), 32);
  imm_s <= resize(signed(instr(31 downto 25) & instr(11 downto 7)), 32);
  imm_sb <=
    resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8)), 31) & '0';
  imm_uj <=
    resize(signed(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'), 32);
  imm_u <= signed(instr(31 downto 12)) & X"000";
  opcode <= instr(6 downto 0);
  format <=
    R_type when opcode = 7X"33" else
    I_type when opcode = 7X"03" or opcode = 7X"13" or opcode = 7X"67" else
    S_type when opcode = 7X"023" else
    SB_type when opcode = 7X"63" else
    UJ_type when opcode = 7X"6F" else
    U_type when opcode = 7X"37";
  imm32 <=
    imm_r when format = R_type else
    imm_i when format = I_type else
    imm_s when format = S_type else
    imm_sb when format = SB_type else
    imm_uj when format = UJ_type else
    imm_u when format = U_type;
end arch;