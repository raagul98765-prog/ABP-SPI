
/********************************************************************************************

Copyright 2024 - Maven Silicon Softech Pvt Ltd.  
www.maven-silicon.com

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.

Filename                :       spi_intf.sv   

module Name             :       spi intf

Description             :       SPI Interface for SPI Core Testbench


*********************************************************************************************/
 
interface spi_if(input bit clk);
	logic ss,sclk,mosi,miso,spi_inpt_req;

	clocking spi_drv_cb @(posedge clk);
		default input #1 output #1;
		input mosi,sclk,ss,spi_inpt_req;
		output miso;
	endclocking

	clocking spi_mon_cb @(posedge clk);
		default input #1 output #1;
		input mosi,sclk,ss,spi_inpt_req,miso;
	endclocking

	modport spi_drv_mp (clocking spi_drv_cb);
	modport spi_mon_mp (clocking spi_mon_cb);
endinterface


