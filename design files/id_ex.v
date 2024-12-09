//Author: Huang Chaofan
//Function: ID/EX_DFF
module id_ex(
	input wire				 	  clk,
	input wire				 	  rst,         // high is reset

	input wire signed[31:0]       read_data1,
	input wire signed[31:0]       read_data2,
	input wire signed[31:0] 	  imm,
	input wire [31:0]			  inst_addr1,
	input wire [31:0]			  inst,

	input wire			 		  branch,
	input wire				 	  mem_read,
	input wire				 	  mem_to_reg,
	input wire [1:0]		 	  alu_op,
	input wire				 	  mem_write,
	input wire			 	 	  alu_src,
	input wire				 	  reg_write,
	input wire [4:0]        	  reg_id_w,
	input wire [4:0]			  tag1,

	output reg signed[31:0]		  read_data1_o,
	output reg signed[31:0]       read_data2_o,
	output reg signed[31:0]		  imm_o,
	output reg [31:0]			  inst_addr2,
	output reg [31:0]			  inst_o,

	output reg 			 	 	  branch_o,
	output reg				 	  mem_read_o,
	output reg				 	  mem_to_reg_o,
	output reg [1:0]		 	  alu_op_o,
	output reg				 	  mem_write_o,
	output reg			 	 	  alu_src_o,
	output reg				 	  reg_write_o,
	output reg [4:0]        	  reg_id_wo,
	output reg [4:0]			  tag1_o

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
			read_data1_o <= 0;
		else
			read_data1_o <= read_data1;
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
			imm_o <= 0;
		else
			imm_o <= imm;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			inst_addr2 <= 0;
		else
			inst_addr2 <= inst_addr1;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			inst_o <= 0;
		else
			inst_o <= inst;
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
			alu_op_o <= 0;
		else
			alu_op_o <= alu_op;
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
			alu_src_o <= 0;
		else
			alu_src_o <= alu_src;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			reg_write_o <= 0;
		else
			reg_write_o <= reg_write;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			reg_id_wo <= 0;
		else
			reg_id_wo <= reg_id_w;
	end
endmodule
