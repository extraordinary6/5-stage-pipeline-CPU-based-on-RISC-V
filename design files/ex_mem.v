//Author: Huang Chaofan
//Function: EX/MEM_DFF
module ex_mem(
	input wire				 	  clk,
	input wire				 	  rst,         // high is reset

	input wire signed[31:0]       read_data2,
	input wire signed[31:0]		  result,
	input wire 					  zero,

	input wire			 		  branch,
	input wire				 	  mem_read,
	input wire				 	  mem_to_reg,
	input wire				 	  mem_write,
	input wire				 	  reg_write,

	input wire signed[31:0] 	  imm,
	input wire [31:0] 	  		  inst_addr2,
	input wire [4:0]        	  reg_id_w,
	input wire [4:0]			  tag1,
	input wire [4:0]			  tag2,

	output reg signed[31:0]       read_data2_o,
	output reg signed[31:0]		  result_o,
	output reg 				  	  zero_o,


	output reg 			 	 	  branch_o,
	output reg				 	  mem_read_o,
	output reg				 	  mem_to_reg_o,
	output reg				 	  mem_write_o,
	output reg				 	  reg_write_o,

	output reg signed[31:0]		  branch_pc,
	output reg [4:0]        	  reg_id_wo,
	output reg [4:0]		 	  tag1_o,
	output reg [4:0]		  	  tag2_o
);

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			tag1_o <= 0;
		else
			tag1_o <= tag1;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			tag2_o <= 0;
		else
			tag2_o <= tag2;
	end

	always @(posedge clk or posedge rst)
	begin	
		if(rst)
			read_data2_o <= 0;
		else
			read_data2_o <= read_data2;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			result_o <= 0;
		else
			result_o <= result;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			zero_o <= 0;
		else
			zero_o <= zero;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			branch_o <= 0;
		else
			branch_o <= branch;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			branch_pc <= 0;
		else
			branch_pc <= inst_addr2 + imm;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			mem_read_o <= 0;
		else
			mem_read_o <= mem_read;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			mem_to_reg_o <= 0;
		else
			mem_to_reg_o <= mem_to_reg;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			mem_write_o <= 0;
		else
			mem_write_o <= mem_write;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			reg_id_wo <= 0;
		else
			reg_id_wo <= reg_id_w;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			reg_write_o <= 0;
		else
			reg_write_o <= reg_write;
	end

endmodule
