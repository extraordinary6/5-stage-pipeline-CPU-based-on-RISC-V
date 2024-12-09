//Author: Huang Chaofan
//Function: ALU_Controller
module alu_control(
	input wire [1:0]	alu_op,
	input wire [6:0]	func7,
	input wire [2:0]	func3,

	output reg [3:0]	state

);
	always @(*)//state
	begin
		case(alu_op)
		2'b10://R-type
		begin
			if(func3 == 3'b000) 
			begin
				if(func7 == 7'b0000000)
					state = 4'b0000;//add
				else if(func7 == 7'b0100000)
					state = 4'b0001;//sub
				//else if(func7 == 7'b0000001)
					//state = 4'b1100;//mul
				else
					state = 4'b1111;//should not happen
			end
			else if(func3 == 3'b001)
				state = 4'b0010;//sll
			//else if(func3 == 3'b010)
				//state = 4'b1110;//slt
			else if(func3 == 3'b100)
				state = 4'b0011;//xor
			else if(func3 == 3'b101)
				state = 4'b0100;//srl
			else if(func3 == 3'b110)
				state = 4'b0101;//or
			else if(func3 == 3'b111)
				state = 4'b0110;//and
			else
				state = 4'b1111;//should not happen
		end
		2'b00://I-type & S-type
		begin
			if(func3 == 3'b010)
				state = 4'b0000;//lw & sw
			else if(func3 == 3'b000)
				state = 4'b0000;//addi
			else 
				state = 4'b1111;//should not happen
		end
		2'b01://SB-type
		begin
			if(func3 == 3'b000)
				state = 4'b1001;//beq
			else if(func3 == 3'b100)
				state = 4'b1010;//blt
			else 
				state = 4'b1111;//should not happen
		end
		2'b11://UJ-type
		begin
			state = 4'b1011;//jal
		end
		default:
			state = 4'b1111;//should not happen
		endcase
	end

endmodule

