//Author: Huang Chaofan
//Function: Execution / ALU
module ex(
	input wire [3:0]		 state,
	input wire signed[31:0]  operand1,
	input wire signed[31:0]  operand2,
	input wire [31:0]		 inst_addr_o,
	
	output reg 				 zero,
	output reg signed[31:0]  result
);

	always @(*)//zero
	begin
		if(state == 4'b1011)//jal
			zero = 1;
		else if(state == 4'b1010 && result < 0)//blt
			zero = 1;
		else if(state == 4'b1001 && result == 0)//beq
			zero = 1;
		else 
			zero = 0;
	end

	always @(*)//result
	begin
		case(state)
		4'b0000://add  lw & sw  addi
			result = operand1 + operand2;
		4'b0001://sub
			result = operand1 - operand2;
		4'b0010://sll
			result = operand1 << operand2;
		4'b0011://xor
			result = operand1 ^ operand2;
		4'b0100://srl
			result = operand1 >> operand2;
		4'b0101://or
			result = operand1 | operand2;
		4'b0110://and
			result = operand1 & operand2;
		4'b1001://beq
			result = operand1 - operand2;
		4'b1010://blt
			result = operand1 - operand2;
		4'b1011://jal		
			result = inst_addr_o + 4;
		/*4'b1100://mul
			result = operand1 * operand2;
		4'b1110://slt
			result = (operand1 < operand2)? 1:0;*/
		default://should not happen
			result = 32'hxxxx_xxxx;
		endcase
	end

endmodule

