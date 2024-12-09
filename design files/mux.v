//Author: Huang Chaofan
//Function: Multiplexer
module mux(
	input wire						enable,
	input wire  signed[31:0]		data_in0,
	input wire  signed[31:0]		data_in1,

	output wire signed[31:0]		data_out
);

	assign data_out = (enable)? data_in1 : data_in0;

endmodule

