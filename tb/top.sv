module top;

	import spi_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	bit clk;
	always #5 clk=~clk;

	spi_if in0(clk);
	apb_if in1(clk);
	
	spi_core DUT(.PCLK(clk),.PRESETn(in1.presetn),.PADDR(in1.paddr),.PWRITE(in1.pwrite),
			.PSEL(in1.psel),.PENABLE(in1.penable),.PWDATA(in1.pwdata),.PRDATA(in1.prdata),
			.PREADY(in1.pready),.PSLVERR(in1.pslverr),
			.miso(in0.miso),.ss(in0.ss),.sclk(in0.sclk),.mosi(in0.mosi),
			.spi_interrupt_request(in0.spi_inpt_req));




	initial
		begin

				uvm_config_db#(virtual spi_if)::set(null,"*","spi_if",in0);
				uvm_config_db#(virtual apb_if)::set(null,"*","apb_if",in1);
				run_test();

		end
endmodule










