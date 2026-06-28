class spi_agent extends uvm_agent;
	`uvm_component_utils(spi_agent)

	spi_driver   sdrvh;
	spi_monitor  smonh;
	spi_sequencer sseqh;
	spi_agt_config spi_cfg;
	

	function new(string name="spi_agent",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
			if(!uvm_config_db #(spi_agt_config)::get(this,"","spi_agt_config",spi_cfg))
				`uvm_fatal("spi_agt_config","cannot get")
			
			smonh=spi_monitor::type_id::create("smonh",this);

			if(spi_cfg.is_active==UVM_ACTIVE) 
			begin
				sdrvh=spi_driver::type_id::create("sdrvh",this);
				sseqh=spi_sequencer::type_id::create("sseqh",this);
			end
	endfunction

	function void connect_phase(uvm_phase phase);
   		if(spi_cfg.is_active==UVM_ACTIVE)
			begin
				sdrvh.seq_item_port.connect(sseqh.seq_item_export);
				super.connect_phase(phase);
			end
	endfunction	

endclass























