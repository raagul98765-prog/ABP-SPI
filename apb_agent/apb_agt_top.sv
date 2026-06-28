class apb_agt_top extends uvm_env;
	`uvm_component_utils(apb_agt_top)

	apb_agent apb_agth[];
	spi_env_config env_cfg;


	function new(string name="apb_agt_top",uvm_component parent);
		super.new(name,parent);
	endfunction

        function void build_phase(uvm_phase phase);
        	super.build_phase(phase);

			if(!uvm_config_db #(spi_env_config)::get(this,"","spi_env_config",env_cfg))
           		`uvm_fatal("CONFIG","cannot get it")

		        if(env_cfg.has_apb_agt)
				begin
					apb_agth = new[env_cfg.no_of_apb_agents];
					foreach(apb_agth[i])
						begin
							uvm_config_db #(apb_agt_config)::set(this,"*","apb_agt_config",env_cfg.apb_cfg[i]);
							apb_agth[i]=apb_agent::type_id::create($sformatf("apb_agth[%0d]",i),this);
						end
				end	
        endfunction
endclass










