//////////////////////////////////////////////////////////////////////////////////
// Nome do Projeto: Nucleo MIPS Monociclo Simplificado (Projeto 02)
// Semestre Letivo: 2025.1
// Atividade: Projeto 02 - Implementacao de MIPS em Verilog
// Grupo: BERY Devs - AOC 2025.1
// Integrantes:
//   - Breno Jordao
//   - Esdras Rodrigues
//   - Rony Elias
//   - Yuri Catunda
//////////////////////////////////////////////////////////////////////////////////

// O modulo ULA (Unidade Logica e Aritmetica) faz as contas da CPU.
module ula (
    In1,        // Entrada: Primeiro numero pra conta (32 bits)
    In2,        // Entrada: Segundo numero pra conta (32 bits)
    OP,         // Entrada: O codigo que diz qual conta fazer (4 bits)
    result,     // Saida: O resultado da conta (32 bits)
    Zero_flag,  // Saida: Vira 1 se o resultado for zero, 0 se nao for
    shamt,      // Entrada: Quantos bits mover (para operacoes de "shift" fixo)
    immediate,  // Entrada: Um valor constante (16 bits), usado em algumas operacoes (como LUI, ORI)
    bne         // Entrada: Sinal para a flag Zero (se for 1, Zero_flag inverte a logica de == 0 para != 0, pra BNE)
);

input wire [31:0] In1, In2;      // Nossos dois numeros de entrada, de 32 bits.
input wire [3:0] OP;            // O codigo de 4 bits que define a operacao que a ULA vai realizar.
input wire [4:0] shamt;         // A quantidade de bits para deslocamento (shifts), de 5 bits.
output reg [31:0] result;       // O resultado da operacao da ULA, armazenado aqui.
output wire Zero_flag;          // A flag que indica se o 'result' da ULA eh zero ou nao.

input wire [15:0] immediate;    // O valor imediato (constante) de 16 bits, usado por instrucoes tipo I.
input wire bne;                 // Sinal para instrucao BNE (Branch Not Equal). Se for 1, a logica da 'Zero_flag' muda para detectar "nao-igual".


// Se 'bne' for 1 (para BNE), Zero_flag sera 1 se o resultado for diferente de zero.
// Se 'bne' for 0 (para BEQ ou outras operacoes), Zero_flag sera 1 se o resultado for IGUAL a zero.
assign Zero_flag = bne ? (result != 0) : (result == 0);


always @(*) begin               // Esse bloco 'always @(*)' significa que a ULA eh um circuito puramente combinacional.
    case (OP)                   // Recupera o codigo de operacao (OP) e faz a conta certa.
        4'b0000: result <= In2 << shamt;                 // sll
        4'b0001: result <= In2 >> shamt;                 // srl
        4'b0010: result <= $signed ($signed (In2) >>> shamt); // sra
        4'b0011: result <= $unsigned($unsigned(In2) << $unsigned(In1)); // sllv
        4'b0100: result <= $unsigned($unsigned(In2) >> $unsigned(In1)); // srlv
        4'b0101: result <= $signed($signed(In2) >> $signed(In1)); // srav
        4'b0110: result <= In1 + In2;                    // add
        4'b0111: result <= In1 - In2;                    // sub
        4'b1000: result <= In1 & In2;                    // and
        4'b1001: result <= In1 | In2;                    // or
        4'b1010: result <= In1 ^ In2;                    // xor
        4'b1011: result <= ~ (In1 | In2);                // nor
        4'b1100: result <= (In1 < In2) ? 32'h00000001 : 32'h00000000; // slt
        4'b1101: result <= ($unsigned(In1) < $unsigned(In2)) ? 32'h00000001 : 32'h00000000; // sltu
        4'b1110: result <= {immediate, 16'b0};           // lui
        4'b1111: result <= In1 | {16'b0, immediate};     // ori
        default: result <= 0;                            // Default
    endcase
end

endmodule