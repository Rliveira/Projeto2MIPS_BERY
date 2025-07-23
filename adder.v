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


// Modulo somador
module adder ( input wire [31:0] valor1,  
                input wire [31:0] valor2,    
  
                  output reg [31:0] soma);

always @(*) begin
  soma = valor1 + valor2;  
end
endmodule