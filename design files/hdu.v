//Author: Huang Chaofan
//Function: Hazard Detection Unit
module hdu(
	input wire [31:0] 		inst_i,
	input wire [31:0]		inst_id,
	input wire [31:0]		inst_ex,
	input wire 			branch,
	input wire			reg_write,
	input wire [4:0]		reg_id_w,
	input wire [4:0]		tag1_i,
	input wire [4:0]		tag2_i,

	output reg [4:0]		tag1,
	output reg [4:0]		tag2,
	output reg			stall_data1,
	output reg			stall_data2,
	output reg			stall_ctrl
);

	always @(*)//control hazard for JAL or BLT or BEQ
	begin
		if(inst_id[6:0] == 7'b1100011 || inst_id[6:0] == 7'b1101111)
			stall_ctrl = 1;
		else if(branch)
			stall_ctrl = 0;
		else
			stall_ctrl = stall_ctrl;
	end

	always @(*)//data hazard detection2
	begin
		if(tag2_i == reg_id_w && reg_id_w != 0)
		begin
			stall_data2 = 0;
		end
		else if(inst_ex[6:0] != 7'b1100011 && inst_ex[6:0] != 7'b0100011 && inst_ex[11:7] != 0)
		begin
			if(inst_i[6:0] == 7'b0000011 || inst_i[6:0] == 7'b0010011)
			begin
				if(inst_ex[11:7] == inst_i[19:15]) begin
					stall_data2 = 1;
					tag2 = inst_ex[11:7];
				end
			end
			else 
			begin
				if(inst_ex[11:7] == inst_i[19:15] || inst_ex[11:7] == inst_i[24:20]) begin
					stall_data2 = 1;
					tag2 = inst_ex[11:7];
				end
			end
		end
		else 
		begin
			stall_data2 = stall_data2;
			tag2 = 0;
		end
	end

	always @(*)//data hazard detection1
	begin
		if(tag1_i == reg_id_w && reg_id_w != 0)
		begin
			stall_data1 = 0;

		end
		else if(inst_id[6:0] != 7'b1100011 && inst_id[6:0] != 7'b0100011 && inst_id[11:7] != 0)
		begin
			if(inst_i[6:0] == 7'b0000011 || inst_i[6:0] == 7'b0010011)
			begin
				if(inst_id[11:7] == inst_i[19:15]) begin
					stall_data1 = 1;
					tag1 = inst_id[11:7];
				end
			end
			else
			begin
				if(inst_id[11:7] == inst_i[19:15] || inst_id[11:7] == inst_i[24:20]) begin
					stall_data1 = 1;
					tag1 = inst_id[11:7];
				end
			end
		end
		else
		begin
			stall_data1 = stall_data1;
			tag1 = 0;
		end
	end
endmodule
