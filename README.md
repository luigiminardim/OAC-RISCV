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
