timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Authors: Bryan Pesquera, Christian Esteves
//
// Create Date:   08:00:35 03/24/2017
// Design Name:   ipcg
// Module Name:   /home/somewhereovertherainbow/memoryBlockSimTB.v
// Project Name:  MemoryBlockSimulator
// Description: 
//
// Verilog Test Fixture created by ISE for module: ipcg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Write WidthL 8 bits, Write Depth: 16 bits. Valid Flag "ON".
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench5;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] din;
	reg wr_en;
	reg rd_en;

	// Outputs
	wire [7:0] dout;
	wire full;
	wire empty;
	wire valid;

	// Instantiate the Unit Under Test (UUT)
	ipcg uut (
		.clk(clk), 
		.rst(rst), 
		.din(din), 
		.wr_en(wr_en), 
		.rd_en(rd_en), 
		.dout(dout), 
		.full(full), 
		.empty(empty), 
		.valid(valid)
	);
	
	always begin 
	#5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		din = 0;
		wr_en = 0;
		rd_en = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//part i : reset FIFO, wait
		rst = 1;
		#30
		rst = 0;
		
		//part ii : write 3 data, read the data
		@(posedge clk) 
		//write 3
		wr_en = 1;
		#20 din = 8'b00000001;
		#20 wr_en = 0;
		#20 wr_en = 1;
		#20 din = 8'b00000010;
		#20 wr_en = 0;
		#20 wr_en = 1;
		#20 din = 8'b00000011;
		#20 wr_en = 0;
		
		//read 3
		#20 rd_en = 1;
		#20 rd_en = 0;

		#100;
		
		//part iii : write 3 data, read 2 data, write 14 data, reset.
		rst = 1;
		//write 3
		#30 rst = 0;
		#30 wr_en =1;
		din = 8'b00000111;
		#30 wr_en = 0;
		#30 wr_en =1;
		din = 8'b00001011;
		#30 wr_en = 0;
		
		//read 2
		#30 rd_en = 1;
		#30 rd_en = 0;
		#30 wr_en =1;
		din = 8'b00010011;
		#30 wr_en = 0;
		#30 rd_en = 1;
		#30 rd_en = 0;
		#100;
		
		//write 14
		#30 wr_en = 1;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 din = 8'b00001011;
		#30 wr_en = 0;
		
		//reset
		rst = 1;
		#30
		rst = 0;
    
		//Part iv : read empty FIFO
		//read empty
		#100;
		#30 rd_en = 1;
		#30 rd_en = 0;
		
		//Part v : write until FIFO full
		//WORKING ON THIS, THE FINAL PART
    
	end
      
endmodule
