//Author: Huang Chaofan
//Function: Memory Access
module mem(
	input wire [31:0]		 address,
	input wire signed[31:0]	 data_write,
	input wire 				 mem_write,
	input wire				 mem_read,
	
	output reg               data_we_o,
    output reg               data_ce_o,
	output wire [31:0]       data_addr_o,
	output wire signed[31:0] data_o       // store data to  data_mem
);

	assign data_addr_o = address;
	assign data_o = data_write;

	always @(*)//data_we_o
	begin
		if(mem_write)
			data_we_o <= 1;
		else if(mem_read)
			data_we_o <= 0;
		else
			data_we_o <= data_we_o;
	end

	always @(*)//data_ce_o
	begin
		if(mem_write || mem_read)
			data_ce_o <= 1;
		else
			data_ce_o <= 0;
	end


endmodule


