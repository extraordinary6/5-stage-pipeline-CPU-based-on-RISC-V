//Author: Huang Chaofan
//Function: Instruction Decode
module id(
	input wire				 	   clk,
	input wire				 	   rst,         // high is reset
	input wire [4:0]        	   reg_id_w,
	input wire [4:0]        	   reg_id1,
	input wire [4:0]        	   reg_id2,
	input wire				 	   reg_write,

	input wire signed[31:0] 	   write_data,
	output wire signed[31:0]       read_data1,
	output wire signed[31:0]       read_data2

);

//	variable define
	reg	[31:0] register [31:0];

	assign read_data2 = $signed(register[reg_id2]);
	assign read_data1 = $signed(register[reg_id1]);

	always @(*)//register
	begin
		if(rst) 
		begin
			register[0] <= 0;
			register[1] <= 0;
			register[2] <= 0;
			register[3] <= 0;
			register[4] <= 0;
			register[5] <= 0;
			register[6] <= 0;
			register[7] <= 0;
			register[8] <= 0;
			register[9] <= 0;
			register[10] <= 0;
			register[11] <= 0;
			register[12] <= 0;
			register[13] <= 0;
			register[14] <= 0;
			register[15] <= 0;
			register[16] <= 0;
			register[17] <= 0;
			register[18] <= 0;
			register[19] <= 0;
			register[20] <= 0;
			register[21] <= 0;
			register[22] <= 0;
			register[23] <= 0;
			register[24] <= 0;
			register[25] <= 0;
			register[26] <= 0;
			register[27] <= 0;
			register[28] <= 0;
			register[29] <= 0;
			register[30] <= 0;
			register[31] <= 0;
		end
		else if(reg_write && reg_id_w != 0)
			register[reg_id_w] <= write_data;
		else
		begin
			register[0] <= register[0] ;
			register[1] <= register[1] ;
			register[2] <= register[2] ;
			register[3] <= register[3] ;
			register[4] <= register[4] ;
			register[5] <= register[5] ;
			register[6] <= register[6] ;
			register[7] <= register[7] ;
			register[8] <= register[8] ;
			register[9] <= register[9] ;
			register[10] <= register[10] ;
			register[11] <= register[11] ;
			register[12] <= register[12] ;
			register[13] <= register[13] ;
			register[14] <= register[14] ;
			register[15] <= register[15] ;
			register[16] <= register[16] ;
			register[17] <= register[17] ;
			register[18] <= register[18] ;
			register[19] <= register[19] ;
			register[20] <= register[20] ;
			register[21] <= register[21] ;
			register[22] <= register[22] ;
			register[23] <= register[23] ;
			register[24] <= register[24] ;
			register[25] <= register[25] ;
			register[26] <= register[26] ;
			register[27] <= register[27] ;
			register[28] <= register[28] ;
			register[29] <= register[29] ;
			register[30] <= register[30] ;
			register[31] <= register[31] ;
		end
	end
endmodule

