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

// O modulo 'ula_ctrl' eh quem decide qual operacao a ULA vai fazer.
module ula_ctrl (
    ALUOp,   // Entrada: um codigo geral que vem do controlador principal
    func,    // Entrada: o "campo funct" da instrucao (pra operacoes R-type)
    Op       // Saida: o codigo especifico que a ULA entende
);

input wire [3:0] ALUOp; // ALUOp: o controlador principal manda 4 bits pra ca.
input wire [5:0] func;  // func: os ultimos 6 bits da instrucao R-type vem pra ca.

output reg [3:0] Op;    // Op: nossa saida de 4 bits, eh o que a ULA vai usar.

reg [3:0] _Op;          // _Op: um "rascunho" interno pra guardar o que a gente decide, antes de sair.

always @(*) begin // Esse bloco 'always @(*)' significa que a gente ta criando um circuito combinacional.
    case (func)             // A gente olha pro 'func' primeiro, pras operacoes R-type.
        6'b000000: _Op = 4'b0000; // sll
        6'b000010: _Op = 4'b0001; // srl
        6'b000011: _Op = 4'b0010; // sra
        6'b000100: _Op = 4'b0011; // sllv
        6'b000110: _Op = 4'b0100; // srlv
        6'b000111: _Op = 4'b0101; // srav
        6'b100000: _Op = 4'b0110; // add
        6'b100010: _Op = 4'b0111; // sub
        6'b100100: _Op = 4'b1000; // and
        6'b100101: _Op = 4'b1001; // or
        6'b100110: _Op = 4'b1010; // xor
        6'b100111: _Op = 4'b1011; // nor
        6'b101010: _Op = 4'b1100; // slt
        6'b101001: _Op = 4'b1101; // sltu
        default: _Op = 4'b0000;   // Default
    endcase
end

always @(*) begin // Esse e o segundo bloco 'always @(*)', tambem combinacional.
    case (ALUOp)            // Agora a gente olha pro 'ALUOp' que veio do controlador principal.
        4'b0000: Op = 4'b0110;  // add
        4'b0001: Op = 4'b0111;  // sub
        4'b0010: Op = 4'b1000;  // and
        4'b0011: Op = 4'b1001;  // or
        4'b0100: Op = 4'b1010;  // xor
        4'b0101: Op = 4'b1100;  // slt
        4'b0110: Op = 4'b1101;  // sltu
        4'b0111: Op = _Op;      // R-type (usa o resultado do 'func')
        4'b1000: Op = 4'b1110;  // lui
        4'b1001: Op = 4'b1111;  // ori
        default: Op = 4'b0000;  // Default
    endcase
end


endmodule