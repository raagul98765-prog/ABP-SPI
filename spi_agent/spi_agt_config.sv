class spi_agt_config extends uvm_object;
	`uvm_object_utils(spi_agt_config)
	
	virtual spi_if vif1;

	uvm_active_passive_enum is_active = UVM_ACTIVE;

	function new(string name = "spi_agt_config");
		super.new(name);
	endfunction

endclass



