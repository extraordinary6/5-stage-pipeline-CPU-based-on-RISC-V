//Author: Huang Chaofan
//Function: MEM/WB_DFF
module mem_wb(
	input wire				 	  clk,
	input wire				 	  rst,         // high is reset
	
	input wire 		  			  mem_to_reg,
	input wire				 	  reg_write,
	input wire signed[31:0]		  result,
	input wire signed[31:0]       data_i,	   // load data from data_mem
	input wire [4:0]        	  reg_id_w,
	input wire					  branch,
	input wire [4:0]			  tag1,
	input wire [4:0]			  tag2,

	output reg					  mem_to_reg_o,
	output reg				 	  reg_write_o,
	output reg signed[31:0]		  result_o,
	output reg signed[31:0]		  data_read,
	output reg [4:0]        	  reg_id_wo,
	output reg					  branch_o,
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
			mem_to_reg_o <= 0;
		else
			mem_to_reg_o <= mem_to_reg;
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
			result_o <= 0;
		else
			result_o <= result;
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			data_read <= 0;
		else
			data_read <= data_i;
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
			branch_o <= 0;
		else
			branch_o <= branch;
	end
endmodule
