//Author: Huang Chaofan
//Function: Controller
module control(
	input wire [6:0]  		 opcode,
	
	output reg 			 	 branch,
	output reg				 mem_read,
	output reg				 mem_to_reg,
	output reg [1:0]		 alu_op,
	output reg				 mem_write,
	output reg			 	 alu_src,
	output reg				 reg_write
);

	always @(*) 
	begin
		case(opcode)
		7'b0110011://R-type
		begin
			branch     = 0;
			mem_read   = 0;
			mem_to_reg = 0;
			alu_op     = 2'b10;
			mem_write  = 0;
			alu_src    = 0;
			reg_write  = 1;
		end
		7'b0000011://lw
		begin
			branch     = 0;
			mem_read   = 1;
			mem_to_reg = 1;
			alu_op     = 2'b00;
			mem_write  = 0;
			alu_src    = 1;
			reg_write  = 1;
		end
		7'b0010011://addi
		begin
			branch     = 0;
			mem_read   = 0;
			mem_to_reg = 0;
			alu_op     = 2'b00;
			mem_write  = 0;
			alu_src    = 1;
			reg_write  = 1;
		end
		7'b0100011://sw
		begin
			branch     = 0;
			mem_read   = 0;
			mem_to_reg = 1'bx;
			alu_op     = 2'b00;
			mem_write  = 1;
			alu_src    = 1;
			reg_write  = 0;
		end
		7'b1100011://SB-type
		begin
			branch     = 1;
			mem_read   = 0;
			mem_to_reg = 1'bx;
			alu_op     = 2'b01;
			mem_write  = 0;
			alu_src    = 0;
			reg_write  = 0;
		end
		7'b1101111://jal
		begin
			branch     = 1;
			mem_read   = 0;
			mem_to_reg = 0;
			alu_op     = 2'b11;
			mem_write  = 0;
			alu_src    = 1;
			reg_write  = 1;
		end
		7'b0000000://stall: addi x0, x0, 0;
		begin
			branch     = 0;
			mem_read   = 0;
			mem_to_reg = 0;
			alu_op     = 2'b00;
			mem_write  = 0;
			alu_src    = 1;
			reg_write  = 1;
		end
		default://should not happen
		begin
			branch     = 1'bx;
			mem_read   = 1'bx;
			mem_to_reg = 1'bx;
			alu_op     = 2'bxx;
			mem_write  = 1'bx;
			alu_src    = 1'bx;
			reg_write  = 1'bx;
		end
		endcase
	end

endmodule

