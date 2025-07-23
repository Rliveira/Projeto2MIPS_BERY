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

// Modulo 'dmem' eh a memoria principal onde a CPU guarda e recupera os dados.
module dmem(clock, writeData, address, memWrite, memRead, readData);

parameter memorySize = 256;

input wire [31:0] address;
input wire [31:0] writeData;
input wire memWrite;
input wire memRead;

output wire [31:0] readData;
input clock;
reg [31:0] mainMemory [0:memorySize-1];

integer i;
initial begin
    for (i = 0; i < memorySize; i = i + 1)
    begin
        mainMemory[i] <= 32'b0;
    end
end

always @(posedge clock) begin
    if (memWrite == 1'b1) begin
        mainMemory[address] <= writeData;
    end
end

assign readData = (memRead == 0) ? 32'b0 : mainMemory[address];

endmodule