class spi_env extends uvm_env;
	`uvm_component_utils(spi_env)
	apb_agt_top apb_th;
	spi_agt_top spi_th;
	spi_env_config env_cfg;
	
	spi_sb sb;
	
	function new(string name = "spi_env",uvm_component parent);
		super.new(name,parent);
	endfunction

                 
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		/*	if(!uvm_config_db#(spi_env_config)::get(this,"","spi_env_config",env_cfg))
				`uvm_fatal("ENV","cannot get it")    */

				apb_th = apb_agt_top::type_id::create("apb_th",this);
				spi_th = spi_agt_top::type_id::create("spi_th",this);
				sb = spi_sb::type_id::create("sb",this);

	endfunction

endclass






