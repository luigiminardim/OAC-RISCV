# Trabalho: Geração de Dados Imediatos no RISC-V

**Aluno:** Luigi Minardi Ferreira Maia
**Matrícula:** 17/0017141

## Relatório

Qual a razão do embaralhamento dos bits do imediato no RiscV?

> Os imediados são embaralhados de forma aproveitar o máximo possível das posições dos sinais em
> hardware, diminuindo a quantidade de multiplexadores necessários para a decodificação do imediato.

Por que alguns imediatos não incluem o bit 0?

> Em algumas classes de instruções, o bit menos significativo do imediato é sempre 0, entao ele é
> redundante.

Os imediatos de operações lógicas estendem o sinal?

> Sim.

Como é implementada a instrução NOT no RiscV?

> Ela pode ser implementada com uma operação lógica XORI com o imediato "0xFFFFFFFF".

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
