# Trabalho: Projeto do Banco de Registradores do RISC-V

**Aluno:** Luigi Minardi Ferreira Maia
**Matrícula:** 17/0017141

## Relatório

Qual a opção usada para simular a constante zero em XREGS[0]?

> O banco de registradores é representado em forma de um processo que é acionado toda vez que o clock muda.
> No caso em que o clock mudou para o valor '1' o sinal de write é '1' o banco de registradores tem seu
> um de seus registradores alterados, todavia, o registrador de índice 0 sempre é assinalado para o valor '0'.
> ```vhdl
> write_process : PROCESS (clk)
>   BEGIN
>     IF (wren = '1' AND clk = '1') THEN
>       regs(conv_integer(rd)) <= data;
>       regs(0) <= 32x"0";
>     END IF;
>   END PROCESS;
>  ```
