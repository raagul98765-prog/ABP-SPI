class spi_env_config extends uvm_object;
	`uvm_object_utils(spi_env_config)
	
	int has_spi_agt ;
        int has_apb_agt ;

	apb_agt_config apb_cfg[];
	spi_agt_config spi_cfg[];
	
	int no_of_spi_agents;
	int no_of_apb_agents;


	function new(string name="spi_env_config");
		super.new(name);
	endfunction

endclass





