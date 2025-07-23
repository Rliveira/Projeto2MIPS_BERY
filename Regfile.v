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


//Modulo que organiza todos os registradores
module Regfile (ReadAddr1, ReadAddr2,ReadData1, ReadData2, Clock, WriteData, RegWrite, Reset, WriteAddr);

input [4:0] ReadAddr1;
input [4:0] ReadAddr2;
output reg [31:0] ReadData1;
output reg [31:0] ReadData2;
input Clock;
input [4:0] WriteAddr;
input [31:0] WriteData;
input RegWrite;
input Reset;

// seta o tamanho dos registradores
reg [31:0] arrayreg [31:0];
	integer r = 0;
	
//seta o arrayreg para zero inicialmente
initial 
	 begin
        arrayreg[0] = 0;
    end

//integra o primeiro registrador lido com bae no clock no registrador destino
    always @(ReadAddr1 or Clock) begin 
	 ReadData1 = arrayreg[ReadAddr1];
    end

//integra o segundo registrador lido com bae no clock no registrador destino
    always @(ReadAddr2 or Clock) begin 
	 ReadData2 = arrayreg[ReadAddr2];
    end

//utilizando de posedge, Clock e Reset, a função é resetada quando os registradores são percorridos. 
    always @(posedge Clock or posedge Reset) 
	 begin
		if (Reset) begin
			for(r=0;r<32;r=r+1) begin
            arrayreg[r] <= 32'B0;
            end
        end else begin
        if (RegWrite) begin
            arrayreg[WriteAddr] <= WriteData;
            arrayreg[0] <= 0;
            end
        end
    end

endmodule