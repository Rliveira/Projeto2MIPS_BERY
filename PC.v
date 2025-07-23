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


// Modulo que representar o contador de enderecos do processador
module PC (clock, nextPC, PC);

	input clock;
	input [31:0] nextPC;
	output reg [31:0] PC;


	always @(posedge clock) 
	begin
		PC <= nextPC;
	end
endmodule