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

// Multiplexador 2x1
module mux2 (A, B, sel, X);
	input wire [31:0] A, B;
	input wire sel;
	output reg [31:0] X;

always @(*) begin
	X = sel? B : A;	
end
endmodule