//Author: Huang Chaofan
//Function: ImmGen
module im(
	input wire		 [31:0]	inst_i,
	
	output reg signed[31:0] imm_o

);

	always @(*)//imm_o
	begin
		case(inst_i[6:0])
		7'b0110011://R-type
			imm_o = 4;
		7'b0000011://lw
			imm_o = {{20{inst_i[31]}}, inst_i[31:20]};
		7'b0010011://addi
			imm_o = {{20{inst_i[31]}}, inst_i[31:20]};
		7'b0100011://sw
			imm_o = {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]};
		7'b1100011://SB-type
			imm_o = {{20{inst_i[31]}}, inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
		7'b1101111://jal
			imm_o = {{12{inst_i[31]}}, inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
		default://should not happen
			imm_o = 32'hxxxx_xxxx;
		endcase

	end
endmodule
