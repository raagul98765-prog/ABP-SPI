class spi_agt_top extends uvm_env;
	`uvm_component_utils(spi_agt_top)

	spi_agent spi_agth[];
	spi_env_config env_cfg;
	

	function new(string name="spi_agt_top",uvm_component parent);
		super.new(name,parent);
	endfunction

        function void build_phase(uvm_phase phase);
        	super.build_phase(phase);

			if(!uvm_config_db #(spi_env_config)::get(this,"","spi_env_config",env_cfg))
           			`uvm_fatal("spi_agt_top","cannot get it")
			
		        if(env_cfg.has_spi_agt)
				begin
					spi_agth = new[env_cfg.no_of_spi_agents];
					foreach(spi_agth[i])
						begin
							uvm_config_db #(spi_agt_config)::set(this,"*","spi_agt_config",env_cfg.spi_cfg[i]);
							spi_agth[i]=spi_agent::type_id::create($sformatf("spi_agth[%0d]",i),this);
						end
				end	     
	endfunction

endclass
