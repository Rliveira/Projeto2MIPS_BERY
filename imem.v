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

// Modulo para acessar arquivo de instrucoes
module int_mem(address,i_out);

input [31:0] address;
output reg [31:0] i_out;
reg [31:0] instruction [255:0];

initial begin
    $readmemb("C:/Projeto2MIPS_BERY/instruction.list", instruction);
end
always @(address) begin
    i_out = instruction[address>>2];
end

endmodule
