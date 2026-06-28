class spi_monitor extends uvm_monitor;
	`uvm_component_utils(spi_monitor)
	uvm_analysis_port #(spi_xtn) spi_mon_port;

	spi_agt_config spi_cfg;
	virtual spi_if.spi_mon_mp vif1;

	bit [7:0] ctrl;
	bit cpol;
	bit cphase;
	bit lsb;
	
	function new(string name = "spi_monitor", uvm_component parent);
		super.new(name,parent);
		spi_mon_port=new("spi_mon_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(spi_agt_config)::get(this,"","spi_agt_config",spi_cfg))
			`uvm_fatal("get_type_name","cannot get")

	/*	if(!uvm_config_db #(bit) ::get(this,"","bit",ctrl))
			`uvm_fatal(get_type_name(),"failed to get the ctrl bit")   */

	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif1 = spi_cfg.vif1;
		lsb=ctrl[0];
		cphase=ctrl[2];
		cpol=ctrl[3];

	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
			forever
				begin
				collect();
	// spi_mon_port.write(xtn);
				end
	endtask

	task collect();
			spi_xtn xtn;
			xtn=spi_xtn::type_id::create("xtn");
			$display("iam in mon collect mode");

			wait(vif1.spi_mon_cb.ss ==0 )
	// spi_xtn xtn;
	// xtn=spi_xtn::type_id::create("xtn");
	
	if(lsb)
		begin
			if((!cpol) && (!cphase) || (cpol) && (cphase))
				begin
					for(int i=0 ; i<8 ; i++)
						begin
					@(posedge vif1.spi_mon_cb.sclk)
					xtn.mosi[i] = vif1.spi_mon_cb.mosi;
					xtn.miso[i] = vif1.spi_mon_cb.miso;
					xtn.ss = vif1.spi_mon_cb.ss;
					xtn.spi_inpt_req= vif1.spi_mon_cb.spi_inpt_req;
					xtn.sclk = vif1.spi_mon_cb.sclk;
					end
				end
	
			else 
				begin
					for(int i=0 ; i<8 ; i++)
					begin
					@(negedge vif1.spi_mon_cb.sclk)
					xtn.mosi[i] = vif1.spi_mon_cb.mosi;
					xtn.miso[i] = vif1.spi_mon_cb.miso;
					xtn.ss = vif1.spi_mon_cb.ss;
					xtn.spi_inpt_req=vif1.spi_mon_cb.spi_inpt_req;
					xtn.sclk = vif1.spi_mon_cb.sclk;
					end
				end
		end

	else
		begin
			if((!cpol) && (!cphase) || (cpol) && (cphase))
				begin
					for(int i=7 ; i>=0; i--)
						begin
						@(posedge vif1.spi_mon_cb.sclk);
						xtn.mosi[i] = vif1.spi_mon_cb.mosi;
						xtn.miso[i] = vif1.spi_mon_cb.miso;
						xtn.ss = vif1.spi_mon_cb.ss;
						xtn.spi_inpt_req = vif1.spi_mon_cb.spi_inpt_req;
						xtn.sclk = vif1.spi_mon_cb.sclk;
						end
				end

			else
				begin
					for(int i=7 ; i>=0 ; i--)
						begin
						@(negedge vif1.spi_mon_cb.sclk);
						xtn.mosi[i] = vif1.spi_mon_cb.mosi;
						xtn.miso[i] = vif1.spi_mon_cb.miso;
						xtn.ss = vif1.spi_mon_cb.ss;
						xtn.spi_inpt_req = vif1.spi_mon_cb.spi_inpt_req;
						xtn.sclk = vif1.spi_mon_cb.sclk;
	// uvm_info(get_type_name(),"the transactions from dut to SPI MON is \n %s",xtn.sprint())
	// spi_mon_port.write(xtn);
						end
				end
		end

	`uvm_info(get_full_name(),$sformatf("the transactions from dut to spi_mon is \n %s",xtn.sprint()),UVM_LOW)
	spi_mon_port.write(xtn);	
endtask

endclass




















