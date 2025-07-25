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

// Control: Unidade responsável por enviar todos os sinais de controle, orquestrando os componentes
// para a execução de todas as instruções especificadas.

module control(
			input wire [5:0] opcode, func,
			output reg branch, bne,
			output reg [3:0] aluop,
			output reg memread, memwrite, memtoreg,
		    output reg regdst, regwrite, alusrc,
			output reg jump, output wire jr);
			
	always @(*) begin
		/* defaults */
		aluop[2:0] <= 2'b111;
		alusrc 	   <= 1'b0;
		bne 	   <= 1'b0;
		memread    <= 1'b0;
		memtoreg   <= 1'b0;
		memwrite   <= 1'b0;
		regdst     <= 1'b1;
		regwrite   <= 1'b1;
		jump 	   <= 1'b0;
		
		case(opcode)
			6'b100011: begin 	/* lw */
				memread   <= 1'b1;
				regdst    <= 1'b0;
				memtoreg  <= 1'b1;
				aluop  <= 4'b0000;
				alusrc    <= 1'b1;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				regwrite 	   <= 1'b1;
			end
			6'b001000: begin 	/* addi */
				regdst	  <= 1'b0;
				aluop  <= 4'b0000;
				alusrc	  <= 1'b1;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				memread    <= 1'b0;
				memwrite   <= 1'b0;

			end
			6'b000100: begin 	/* beq */
				aluop  <= 4'b0001;
				branch <= 1'b1;
				regwrite  <= 1'b0;
				alusrc <= 1'b0;
				bne 	   <= 1'b0;
			end
			6'b101011: begin 	/* sw */
				regdst 	  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				memwrite  <= 1'b1;
				aluop  <= 4'b0000;
				alusrc	  <= 1'b1;
				regwrite  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
			end
			6'b000101: begin 	/* bne */
				aluop  <= 4'b0001;
				branch <= 1'b1;
				regwrite  <= 1'b0;
				alusrc <= 1'b0;
				bne <=1'b1;
				memread    <= 1'b0;
				memwrite   <= 1'b0;

			end
			6'b000000: begin	/* add */
				regdst    <= 1'b1;
				regwrite  <= 1'b1;
				alusrc 	  <= 1'b0;
				aluop  <= 3'b111;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				jump 	  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
			end
			6'b000010: begin 	/* j */
				regdst    <= 1'bX;
				regwrite  <= 1'b0;
				alusrc    <= 1'bX;
				aluop     <= 4'bXXX;
				memwrite  <= 1'b0;
				memread	  <= 1'b0;
				memtoreg  <= 1'bX;
				branch <= 1'b0;
				jump      <= 1'b1;
				bne 	   <= 1'b0;
			end
			6'b000011: begin 	/* jal */
				regdst    <= 1'bX;
				regwrite  <= 1'b1;
				alusrc    <= 1'bX;
				aluop     <= 4'bXXX;
				memwrite  <= 1'b0;
				memread	  <= 1'b0;
				memtoreg  <= 1'bX;
				branch <= 1'b0;
				jump      <= 1'b1;
				bne 	   <= 1'b0;
			end
			6'b101010: begin     /* slt */
				regdst    <= 1'b1;
				regwrite  <= 1'b1;
				alusrc    <= 1'b0;
				aluop     <= 4'b101;
				memwrite  <= 1'b0;
				memread   <= 1'b1;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				jump      <= 1'b0;
			end
			6'b101001: begin      /* sltu */
				regdst	  <= 1'b0;
				regwrite  <= 1'b1;
				alusrc	  <= 1'b0;
				aluop     <= 4'b101;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				jump      <= 1'b0;
			end
			6'b100110: begin      /* xor */
				regdst    <= 1'b0;
				regwrite  <= 1'b1;
				alusrc    <= 1'b1;
				aluop     <= 4'b100;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				jump      <= 1'b0;
			end
			6'b100101: begin      /* or */
				regdst    <= 1'b0;
				regwrite  <= 1'b1;
				alusrc    <= 1'b1;
				aluop     <= 4'b011;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				
	
				jump      <= 1'b0;
			end
			6'b100100: begin      /* and */
				regdst    <= 1'b0;
				regwrite  <= 1'b1;
				alusrc    <= 1'b1;
				aluop     <= 4'b010;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				jump      <= 1'b0;
			end
			6'b100010: begin     /* sub */
				regdst    <= 1'b1;
				regwrite  <= 1'b1;
				alusrc    <= 1'b0;
				aluop     <= 4'b110;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				jump      <= 1'b0;
			end
			6'b001111: begin
				regdst    <= 1'b0;
				regwrite  <= 1'b1;
				alusrc    <= 1'b1;
				aluop     <= 4'b1000;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				jump      <= 1'b0;
			end
			6'b001101: begin      /* ori */
				regdst    <= 1'b0;
				regwrite  <= 1'b1;
				alusrc    <= 1'b1;
				aluop     <= 4'b1001;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				jump      <= 1'b0;
			end
			default: begin
				regdst    <= 1'b1;
				regwrite  <= 1'b1;
				alusrc    <= 1'b0;
				aluop     <= 4'b0111;
				memwrite  <= 1'b0;
				memread   <= 1'b0;
				memtoreg  <= 1'b0;
				branch <= 1'b0;
				bne 	   <= 1'b0;
				jump      <= 1'b0;
			end
		endcase
	end
	assign jr = (opcode == 6'b000000) ? ((func == 6'b001000) ? 1'b1 : 1'b0) : 1'b0;
endmodule

			
		
				
			
              
