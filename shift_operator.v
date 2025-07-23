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

// Modulo da operacao shift
module shift_operator (
  l_Shift,
  shift_out
); 
 
  input wire [31:0] l_Shift;
  output reg [31:0] shift_out;

always @(*) begin
  shift_out = l_Shift << 2;
end
   
endmodule