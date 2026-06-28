class spi_sb extends uvm_scoreboard;
	`uvm_component_utils(spi_sb)
	
	function new(string name = "spi_sb",uvm_component parent);
		super.new(name,parent);
	endfunction
endclass
