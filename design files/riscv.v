//Author: Huang Chaofan
//Function: Top Module of Single-cycle Processor Based on Risc-v


module riscv(

	input wire				 clk,
	input wire				 rst,         // high is reset
	
    // inst_mem
	input wire[31:0]         inst_i,
	output wire[31:0]        inst_addr_o,
	output wire              inst_ce_o,

    // data_mem
	input wire[31:0]         data_i,      // load data from data_mem
	output wire              data_we_o,
    output wire              data_ce_o,
	output wire[31:0]        data_addr_o,
	output wire[31:0]        data_o       // store data to  data_mem

);

//	variable
	wire					 stall_data1;
	wire					 stall_data2;
	wire					 stall_ctrl;
	wire signed[31:0]		 branch_pc;

	wire [31:0]				 inst_addr1;	
	wire [31:0]				 inst_addr2;	
	wire [31:0]				 inst_id;
	wire [31:0]				 inst_ex;

	wire signed[31:0]	 	 write_data;
	wire signed[31:0]	 	 read_data1;
	wire signed[31:0]	 	 read_data2;

	wire	 			 	 branch;
	wire					 mem_read;
	wire					 mem_to_reg;
	wire [1:0]				 alu_op;
	wire					 mem_write;
	wire				 	 alu_src;
	wire					 reg_write;
	
	wire signed[31:0]	 	 imm;
	wire signed[31:0]	 	 imm_o;

	wire signed[31:0]		 read_data1_o;
	wire signed[31:0]        read_data2_o;

	wire	 			 	 branch1;
	wire					 mem_read1;
	wire					 mem_to_reg1;
	wire [1:0]				 alu_op1;
	wire					 mem_write1;
	wire				 	 alu_src1;
	wire					 reg_write1;
	wire [4:0]        	  	 reg_id_w1;		

	wire [3:0]		 	 	 state;
	wire signed[31:0]    	 operand2;
	wire signed[31:0]  	 	 result;
	wire 					 zero;

	wire					 zero2;
	wire signed[31:0]        data_write;
	wire signed[31:0]  	 	 result_o;
	
	wire	 			 	 branch2;
	wire					 mem_read2;
	wire					 mem_to_reg2;
	wire					 mem_write2;
	wire					 reg_write2;
	wire [4:0]        	  	 reg_id_w2;		


	wire					 mem_to_reg3;
	wire					 reg_write3;
	wire [4:0]        	  	 reg_id_w3;
	wire					 branch3;
	wire signed[31:0]  	 	 result1;
	wire signed[31:0]  	 	 data_read;

	wire [4:0]			tag1;
	wire [4:0]			tag11;
	wire [4:0]			tag12;
	wire [4:0]			tag13;

	wire [4:0]			tag2;

	wire [4:0]			tag22;
	wire [4:0]			tag23;

//  instance your module  below
	inst_f inst_f0(
	.clk		(clk),
	.rst		(rst),         
	.branch		(branch2),
	.zero		(zero2),
	.stall_data1(stall_data1),
	.stall_data2(stall_data2),
	.stall_ctrl	(stall_ctrl),
	.branch_pc  (branch_pc),

	.inst_addr_o(inst_addr_o),
	.inst_ce_o	(inst_ce_o)
	);

	if_id if_id0(
	.clk		(clk),
	.rst		(rst),  
	.inst_i		(inst_i),
	.inst_addr_o(inst_addr_o),
	.stall_data1(stall_data1),
	.stall_data2(stall_data2),
	.stall_ctrl	(stall_ctrl),

	.inst_addr1 (inst_addr1),	
	.inst		(inst_id)
	);

	control control0(
	.opcode		(inst_id[6:0]),
	
	.branch		(branch),
	.mem_read	(mem_read),
	.mem_to_reg	(mem_to_reg),
	.alu_op		(alu_op),
	.mem_write	(mem_write),
	.alu_src	(alu_src),
	.reg_write	(reg_write)
	);

	id id0(
	.clk		(clk),
	.rst		(rst), 
	.reg_id_w	(reg_id_w3),
	.reg_id1	(inst_id[19:15]),
	.reg_id2	(inst_id[24:20]),
	.reg_write	(reg_write3),

	.write_data	(write_data),
	.read_data1	(read_data1),
	.read_data2	(read_data2)
	);

	im im0(
	.inst_i		(inst_id),
	.imm_o		(imm)
	);

	id_ex id_ex0(
	.clk		(clk),
	.rst		(rst),

	.read_data1	(read_data1),
	.read_data2	(read_data2),
	.imm		(imm),
	.inst_addr1 (inst_addr1),
	.inst		(inst_id),

	.branch		(branch),
	.mem_read	(mem_read),
	.mem_to_reg	(mem_to_reg),
	.alu_op		(alu_op),
	.mem_write	(mem_write),
	.alu_src	(alu_src),
	.reg_write	(reg_write),
	.reg_id_w	(inst_id[11:7]),
	.tag1		(tag1),

	.read_data1_o(read_data1_o),
	.read_data2_o(read_data2_o),
	.imm_o		 (imm_o),
	.inst_addr2	 (inst_addr2),
	.inst_o		 (inst_ex),

	.branch_o	 (branch1),
	.mem_read_o	 (mem_read1),
	.mem_to_reg_o(mem_to_reg1),
	.alu_op_o	 (alu_op1),
	.mem_write_o (mem_write1),
	.alu_src_o	 (alu_src1),
	.reg_write_o (reg_write1),
	.reg_id_wo	 (reg_id_w1),
	.tag1_o		(tag11)
	);

	mux mux0(
	.enable		(alu_src1),
	.data_in0	(read_data2_o),
	.data_in1	(imm_o),
	.data_out	(operand2)
	);

	ex ex0(
	.state		(state),
	.operand1	(read_data1_o),
	.operand2	(operand2),
	.inst_addr_o(inst_addr2),
	.zero		(zero),
	.result		(result)
	);

	alu_control alu_control0(
	.alu_op		(alu_op1),
	.func7		(inst_ex[31:25]),
	.func3		(inst_ex[14:12]),

	.state		(state)
	);
	
	ex_mem ex_mem0(
	.clk		(clk),
	.rst		(rst), 

	.read_data2 (read_data2_o),
	.result	    (result),
	.zero		(zero),

	.branch		(branch1),
	.mem_read	(mem_read1),
	.mem_to_reg	(mem_to_reg1),
	.mem_write	(mem_write1),
	.reg_write	(reg_write1),

	.imm		(imm_o),
	.inst_addr2 (inst_addr2),
	.reg_id_w	(reg_id_w1),
	.tag1		(tag11),
	.tag2		(tag2),

	.read_data2_o(data_write),
	.result_o   (result_o),
	.zero_o		(zero2),

	.branch_o	(branch2),
	.mem_read_o	(mem_read2),
	.mem_to_reg_o(mem_to_reg2),
	.mem_write_o(mem_write2),
	.reg_write_o(reg_write2),

	.branch_pc	(branch_pc),
	.reg_id_wo	(reg_id_w2),
	.tag1_o		(tag12),
	.tag2_o		(tag22)
	);

	mem mem0(
	.address	(result_o),
	.data_write	(data_write),
	.mem_write	(mem_write2),
	.mem_read	(mem_read2),
	
	.data_we_o	(data_we_o),
    .data_ce_o  (data_ce_o),
	.data_addr_o(data_addr_o),
	.data_o		(data_o)       // store data to  data_mem
	);

	mem_wb mem_wb0(
	.clk		(clk),
	.rst		(rst), 
	
	.mem_to_reg (mem_to_reg2),
	.reg_write	(reg_write2),
	.result		(result_o),
	.data_i		(data_i),	   // load data from data_mem
	.reg_id_w	(reg_id_w2),
	.branch		(branch2),
	.tag1		(tag12),
	.tag2		(tag22),

	.mem_to_reg_o(mem_to_reg3),
	.reg_write_o(reg_write3),
	.result_o	(result1),
	.data_read	(data_read),
	.reg_id_wo	(reg_id_w3),
	.branch_o	(branch3),
	.tag1_o		(tag13),
	.tag2_o		(tag23)
	);

	mux mux1(
	.enable		(mem_to_reg3),
	.data_in0	(result1),
	.data_in1	(data_read),
	.data_out	(write_data)
	);

	hdu hdu0(
	.inst_i		(inst_i),
	.inst_id	(inst_id),
	.inst_ex	(inst_ex),
	.branch		(branch3),
	.reg_write	(reg_write3),
	.reg_id_w	(reg_id_w3),
	.tag1_i		(tag13),
	.tag2_i		(tag23),
	.tag1		(tag1),
	.tag2		(tag2),
	.stall_data1(stall_data1),
	.stall_data2(stall_data2),
	.stall_ctrl	(stall_ctrl)
	);
endmodule



