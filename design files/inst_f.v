//Author: Huang Chaofan
//Function: Instrution Fetch
module inst_f(
	input wire				 clk,
	input wire				 rst,         // high is reset
	input wire				 branch,
	input wire				 zero,
	input wire				 stall_data1,
	input wire				 stall_data2,
	input wire				 stall_ctrl,
	input wire signed[31:0]	 branch_pc,
    // inst_mem
	output reg[31:0]         inst_addr_o,
	output reg               inst_ce_o
);


//	sequential logic
	always @(posedge clk or posedge rst)//inst_addr_o
	begin
		if(rst) 
			inst_addr_o <= 0;
		else if(branch && zero && stall_ctrl) 
			inst_addr_o <= branch_pc;
		else if(stall_ctrl || stall_data2 || stall_data1)
			inst_addr_o <= inst_addr_o;
		else 
			inst_addr_o <= inst_addr_o + 4; 
	end

	always @(*)//inst_ce_o
	begin
		if(rst) 
			inst_ce_o = 0;
		else if(stall_ctrl || stall_data1 || stall_data2)
			inst_ce_o = 0;
		else 
			inst_ce_o = 1;
	end


endmodule

