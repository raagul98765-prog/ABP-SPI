class spi_driver extends uvm_driver#(spi_xtn);
	`uvm_component_utils(spi_driver)

	spi_agt_config spi_cfg;
	virtual spi_if.spi_drv_mp vif1;

	bit cphase;
	bit cpol;
	bit lsb;
	bit[7:0] ctrl;
	
	function new(string name = "spi_driver", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(spi_agt_config)::get(this,"","spi_agt_config",spi_cfg))
			`uvm_fatal("get_type_name","cannot get")
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif1 = spi_cfg.vif1;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
			`uvm_info("spi_driver","printing from spi_driver",UVM_LOW)
			req.print();

				seq_item_port.item_done();
			end
	endtask

	task send_to_dut(spi_xtn xtn);
		if(!uvm_config_db #(bit)::get(this,"","bit",ctrl))
			`uvm_fatal(get_type_name(),"cannot get")

		cphase = ctrl[2];
		cpol = ctrl[3];
		lsb = ctrl[0];
		$display("in spiiiiiiiiiiiiiiiiiii driveeeeeeeeeeeeeeeeeeeeeeeeee ");		
		wait(!vif1.spi_drv_cb.ss)
			begin
		$display("in spiiiiiiiiiiiiiiiiiii driveeeeeeeeeeeeeeeeeeeeeeeeee ");

				if(lsb)
					begin
						//cphase = 0,cpol = 0
						if((!cphase) && (!cpol))
							begin
								vif1.spi_drv_cb.miso <= xtn.mosi[0];
								for(int i=1; i<=7; i++)
									begin
										@(negedge vif1.spi_drv_cb.sclk)
										vif1.spi_drv_cb.miso <= xtn.miso[i];
									end
							end
					
				

				//cphase = 0,cpol = 1
				else if((!cphase) && (cpol))
							begin
								vif1.spi_drv_cb.miso <= xtn.mosi[0];
								for(int i=1; i<=7; i++)
									begin
										@(posedge vif1.spi_drv_cb.sclk)
										vif1.spi_drv_cb.miso <= xtn.miso[i];
									end
							end
					
				//cphase = 1,cpol = 0
				else if((cphase) && (!cpol))
						begin
						//	vif1.spi_drv_cb.miso <= xtn.mosi[0];
							for(int i=0; i<=7; i++)
								begin
									@(posedge vif1.spi_drv_cb.sclk)
									vif1.spi_drv_cb.miso <= xtn.miso[i];
								end
						end


				//cphase = 1,cpol = 1
				else if((cphase) && (cpol))
							begin
	
							//	vif1.spi_drv_cb.miso <= xtn.mosi[0];
								for(int i=0; i<=7; i++)
									begin
										@(posedge vif1.spi_drv_cb.sclk)
										vif1.spi_drv_cb.miso <= xtn.miso[i];
									end
							end
					end
			




			/////////////////////////MSB first//////////////////////////////////////////////

			else
				begin
					//cpol = 0,cphase = 0
					if((!cphase) && (!cpol))
					begin
						vif1.spi_drv_cb.miso <= xtn.miso[7];
						for(int i=6; i>=0; i--)
							begin
								@(negedge vif1.spi_drv_cb.sclk)
								vif1.spi_drv_cb.miso <= xtn.miso[i];
							end
					end


					//cphase = 0, cpol = 1
					if((!cphase) && (cpol))
					begin
						vif1.spi_drv_cb.miso <= xtn.miso[7];
						for(int i=6; i>=0; i--)
							begin
								@(negedge vif1.spi_drv_cb.sclk)
								vif1.spi_drv_cb.miso <= xtn.miso[i];
							end
					end

					//cphase = 1, cpol = 0
					if((cphase) && (!cpol))
					begin
						//vif1.spi_drv_cb.miso <= xtn.miso[7];
						for(int i=7; i>=0; i--)
							begin
								@(negedge vif1.spi_drv_cb.sclk)
								vif1.spi_drv_cb.miso <= xtn.miso[i];
							end
					end


					//cphase = 1, cpol = 1
					if((cphase) && (cpol))
					begin

						//vif1.spi_drv_cb.miso <= xtn.miso[7];
						for(int i=7; i>=0; i--)
							begin
								@(negedge vif1.spi_drv_cb.sclk)
								vif1.spi_drv_cb.miso <= xtn.miso[i];
							end
					end
				end
			end
			//xtn.print();
			`uvm_info("spi_driver","printing from spi_driver",UVM_LOW)
	
	endtask
endclass
		
		


	
			
					

					

		


