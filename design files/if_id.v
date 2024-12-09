//Author: Huang Chaofan
//Function: IF/ID_DFF
module if_id(
	input wire			clk,
	input wire			rst,         // high is reset
	input wire [31:0]	inst_i,
	input wire [31:0]	inst_addr_o,
	input wire			stall_data1,
	input wire			stall_data2,
	input wire			stall_ctrl,

	output reg [31:0]	inst_addr1,	
	output reg [31:0]	inst
);

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			inst_addr1 <= 0;
		else if(stall_data1 || stall_data2 || stall_ctrl)
			inst_addr1 <= 0;
		else
			inst_addr1 <= inst_addr_o;		
	end

	always @(posedge clk or posedge rst)
	begin
		if(rst)
			inst <= 0;
		else if(stall_data1 || stall_data2 || stall_ctrl)
			inst <= 0;
		else
			inst <= inst_i;
	end

endmodule
