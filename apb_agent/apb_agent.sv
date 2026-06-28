class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)

	apb_driver  adrvh;     
	apb_monitor amonh;     
	apb_sequencer   aseqh;     
	apb_agt_config apb_cfg;

	function new(string name = "apb_agent",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
			
		if(!uvm_config_db #(apb_agt_config)::get(this,"","apb_agt_config",apb_cfg))
			`uvm_fatal("apb_agt_config","cannot get")
			
		amonh=apb_monitor::type_id::create("amonh",this);

		if(apb_cfg.is_active==UVM_ACTIVE)
			begin
				adrvh=apb_driver::type_id::create("adrvh",this);
				aseqh=apb_sequencer::type_id::create("aseqh",this);
			end
		endfunction

	function void connect_phase(uvm_phase phase);
		if(apb_cfg.is_active==UVM_ACTIVE)
			begin
				adrvh.seq_item_port.connect(aseqh.seq_item_export);
				super.connect_phase(phase);
			end
	endfunction

endclass














