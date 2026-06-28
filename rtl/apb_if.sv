
/********************************************************************************************

Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       apb_intf.sv   

module Name             :       apb intf

Description             :       APB Interface for SPI Core Testbench


*********************************************************************************************/

interface apb_if(input bit clk);
	logic pclk,presetn,psel,pwrite,penable,pready,pslverr;
	logic [2:0] paddr;
	logic [7:0] pwdata,prdata;

	assign pclk=clk;

	clocking apb_drv_cb @(posedge clk);
		default input #1 output #1;
		output pclk,presetn,psel,pwrite,penable,pwdata,paddr;
		input pready,pslverr,prdata;
	endclocking

	clocking apb_mon_cb @(posedge clk);
		default input #1 output #1;
		input pclk,presetn,psel,pwrite,penable,pwdata,paddr,pready,pslverr,prdata;
	endclocking

	modport apb_drv_mp (clocking apb_drv_cb);
	modport apb_mon_mp (clocking apb_mon_cb);

endinterface


