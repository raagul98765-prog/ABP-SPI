class apb_monitor extends uvm_monitor;
	`uvm_component_utils(apb_monitor)
	uvm_analysis_port#(apb_xtn) apb_mon_port;
//	apb_xtn xtn;


	apb_agt_config apb_cfg;
	virtual apb_if.apb_mon_mp vif;


	function new(string name = "apb_monitor",uvm_component parent);
		super.new(name,parent);
		apb_mon_port=new("apb_mon_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
	if(!uvm_config_db#(apb_agt_config)::get(this,"","apb_agt_config",apb_cfg))
		`uvm_fatal("get_type_name()","cannont getting")
	
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		vif=apb_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
	forever

		collect_data();
	endtask

	task collect_data();
	
		apb_xtn xtn;
		xtn=apb_xtn::type_id::create("xtn");

		$display("iam in monitor collect method");
	//	@(vif.apb_mon_cb);
		wait(vif.apb_mon_cb.penable ==1 && vif.apb_mon_cb.pready == 1)
		$display("iam in monitor collect method after wait");


		xtn.PRESETn = vif.apb_mon_cb.presetn;
		xtn.PWRITE = vif.apb_mon_cb.pwrite;
		xtn.PSEL = vif.apb_mon_cb.psel;
		xtn.PADDR = vif.apb_mon_cb.paddr;
		xtn.PENABLE = vif.apb_mon_cb.penable;
		xtn.PREADY = vif.apb_mon_cb.pready;
		xtn.PSLVERR = vif.apb_mon_cb.pslverr;
		if(vif.apb_mon_cb.pwrite)
			xtn.PWDATA = vif.apb_mon_cb.pwdata;
		else
			xtn.PRDATA = vif.apb_mon_cb.prdata;
		`uvm_info(get_type_name(),$sformatf("the transactions from dut to apb_mon is \n %s",xtn.sprint()),UVM_LOW)
		 apb_mon_port.write(xtn);
		@(vif.apb_mon_cb);

	endtask	
endclass
