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

// Modulo JUMP
module jump_control (instruction, pc, jump_address);
input wire [31:0] pc, instruction;
output reg [31:0] jump_address;

always @(*) begin
    jump_address <= {pc[31:28], instruction[25:0], 2'b00};
end

endmodule