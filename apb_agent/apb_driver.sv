class apb_driver extends uvm_driver#(apb_xtn);
	`uvm_component_utils(apb_driver)

	apb_agt_config apb_cfg;
	virtual apb_if.apb_drv_mp vif;


   function new(string name = "apb_driver",uvm_component parent);
	super.new(name,parent);
   endfunction

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		if(!uvm_config_db#(apb_agt_config)::get(this,"","apb_agt_config",apb_cfg))
			`uvm_fatal("get_type_name","cannont get it")
	endfunction


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		$display("huhuhuhu");
		vif=apb_cfg.vif;
	
	endfunction

	task run_phase(uvm_phase phase);
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.presetn <= 1'b0;
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.presetn <= 1'b1;

		forever
			begin
				$display("starting to send items");
				seq_item_port.get_next_item(req);
				$display("before task");
				send_to_dut(req);
				req.print();
				seq_item_port.item_done();
				$display("done send items");

			end
	endtask
	
	task send_to_dut(apb_xtn xtn);
		@(vif.apb_drv_cb);

		vif.apb_drv_cb.paddr <= xtn.PADDR;
		vif.apb_drv_cb.pwrite <= xtn.PWRITE;
		vif.apb_drv_cb.psel <= 1'b1;
		vif.apb_drv_cb.penable <= 1'b0;

		if(xtn.PWRITE)
			begin
				vif.apb_drv_cb.pwdata <= xtn.PWDATA;
			end
			//ENABLE PHASE
			@(vif.apb_drv_cb);
			vif.apb_drv_cb.penable <= 1'b1;

			wait(vif.apb_drv_cb.pready)
		
			if(xtn.PWRITE==1'b0)
			xtn.PRDATA = vif.apb_drv_cb.prdata;

			//IDLE PHASE
			@(vif.apb_drv_cb);
			vif.apb_drv_cb.psel <= 1'b0;
			vif.apb_drv_cb.penable <= 1'b0;

		`uvm_info("APB DRV","PRINTING FROM APB DRV",UVM_NONE)
		xtn.print();
	endtask
	
endclass































