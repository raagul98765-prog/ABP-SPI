class spi_test extends uvm_test;

 	`uvm_component_utils(spi_test)

	spi_env envh;
	spi_env_config env_cfg;
	apb_agt_config apb_cfg[];
	spi_agt_config spi_cfg[];

	int has_spi_agt = 1;
	int has_apb_agt = 1;

	int no_of_spi_agents = 1;
	int no_of_apb_agents = 1;

	function new(string name="spi_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		env_cfg = spi_env_config::type_id::create("env_cfg");

		env_cfg.has_apb_agt   = this.has_apb_agt;
		env_cfg.has_spi_agt   = this.has_spi_agt;

		env_cfg.no_of_apb_agents = this.no_of_apb_agents;
		env_cfg.no_of_spi_agents = this.no_of_spi_agents;

		env_cfg.apb_cfg=new[no_of_apb_agents];
		env_cfg.spi_cfg=new[no_of_spi_agents];

		apb_cfg=new[no_of_apb_agents];
		spi_cfg=new[no_of_spi_agents];


		if(env_cfg.has_apb_agt)
			begin
				foreach(apb_cfg[i])
				begin
					apb_cfg[i]=apb_agt_config::type_id::create($sformatf("apb_cfg[%0d]",i));
		
					if(!uvm_config_db #(virtual apb_if)::get(this,"","apb_if",apb_cfg[i].vif)) 
						`uvm_fatal("apb_if","cannot get")
					apb_cfg[i].is_active=UVM_ACTIVE;
					env_cfg.apb_cfg[i] = apb_cfg[i];
				end
			end

		if(env_cfg.has_spi_agt)
			begin
				foreach(spi_cfg[i])
				begin
					spi_cfg[i]=spi_agt_config::type_id::create($sformatf("spi_cfg[%0d]",i));
					if(!uvm_config_db #(virtual spi_if)::get(this,"","spi_if",spi_cfg[i].vif1))
					`uvm_fatal("SPI_IF","cannot get")
					spi_cfg[i].is_active=UVM_ACTIVE;
					env_cfg.spi_cfg[i] = spi_cfg[i];
				end
			end

		
				uvm_config_db #(spi_env_config)::set(this,"*","spi_env_config",env_cfg); 
				envh=spi_env::type_id::create("envh",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
			uvm_top.print_topology();
			factory.print();
  	endfunction
     
	
endclass




////////////////////////-------LLLSSSBBB-----first----/////////////////////////////

class apb_cpha1_cpol1_lsb_test extends spi_test;
	`uvm_component_utils(apb_cpha1_cpol1_lsb_test)

	apb_cpha1_cpol1_wr_seqs apb_wr_11seq;
	apb_cpha1_cpol1_rd_seqs apb_rd_11seq;

	spi_cpha_cpol_seqs seqh1;

  //  	register_config r_cfg;

	bit [7:0] SPI_CRT=8'b11111110;

	
	function new(string name = "apb_cpha1_cpol1_lsb_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		uvm_config_db #(bit)::set(null,"*","bit",SPI_CRT);

		apb_wr_11seq = apb_cpha1_cpol1_wr_seqs::type_id::create("apb_wr_11seq",this);
		apb_rd_11seq = apb_cpha1_cpol1_rd_seqs::type_id::create("apb_rd_11seq",this);
		seqh1 = spi_cpha_cpol_seqs::type_id::create("seqh");



	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
				phase.raise_objection(this);

			//	fork
					apb_wr_11seq.start(envh.apb_th.apb_agth[0].aseqh);
					seqh1.start(envh.spi_th.spi_agth[0].sseqh);

			//	join
					#100;

					apb_rd_11seq.start(envh.apb_th.apb_agth[0].aseqh);
				
				phase.drop_objection(this);
	endtask
endclass



///////////////////////////////// lsb 1 0 -----------//////
class apb_cpha1_cpol0_lsb_test extends spi_test;
	`uvm_component_utils(apb_cpha1_cpol0_lsb_test)

	apb_cpha1_cpol0_wr_seqs apb_wr_10seq;
	apb_cpha1_cpol0_rd_seqs apb_rd_10seq;

	function new(string name = "apb_cpha1_cpol0_lsb_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_wr_10seq = apb_cpha1_cpol0_wr_seqs::type_id::create("apb_wr_10seq",this);
		apb_rd_10seq = apb_cpha1_cpol0_rd_seqs::type_id::create("apb_rd_10seq",this);

	endfunction
	
	task run_phase(uvm_phase phase);
		repeat(5)
			begin
				phase.raise_objection(this);

				fork
					apb_wr_10seq.start(envh.apb_th.apb_agth[0].aseqh);
				join
				#100;
					apb_wr_10seq.start(envh.apb_th.apb_agth[0].aseqh);

				phase.drop_objection(this);
			end
	endtask
endclass

//////////////////////////////  0  1  /////////////////////////////////////
class apb_cpha0_cpol1_lsb_test extends spi_test;
	`uvm_component_utils(apb_cpha0_cpol1_lsb_test)

	apb_cpha0_cpol1_wr_seqs apb_wr_01seq;
	apb_cpha0_cpol1_rd_seqs apb_rd_01seq;

	function new(string name = "apb_cpha0_cpol1_lsb_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_wr_01seq = apb_cpha0_cpol1_wr_seqs::type_id::create("apb_wr_01seq",this);
		apb_rd_01seq = apb_cpha0_cpol1_rd_seqs::type_id::create("apb_rd_01seq",this);

	endfunction
	
	task run_phase(uvm_phase phase);
		repeat(5)
			begin
				phase.raise_objection(this);

				fork
					apb_wr_01seq.start(envh.apb_th.apb_agth[0].aseqh);
				join
				#100;
					apb_wr_01seq.start(envh.apb_th.apb_agth[0].aseqh);

				phase.drop_objection(this);
			end
	endtask
endclass

/////////////////////////// 0 0 ////////////////////////////////////////////
class apb_cpha0_cpol0_lsb_test extends spi_test;
	`uvm_component_utils(apb_cpha1_cpol1_lsb_test)

	apb_cpha0_cpol0_wr_seqs apb_wr_00seq;
	apb_cpha0_cpol0_rd_seqs apb_rd_00seq;

	function new(string name = "apb_cpha0_cpol0_lsb_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_wr_00seq = apb_cpha0_cpol0_wr_seqs::type_id::create("apb_wr_00seq",this);
		apb_rd_00seq = apb_cpha0_cpol0_rd_seqs::type_id::create("apb_rd_00seq",this);

	endfunction
	
	task run_phase(uvm_phase phase);
		repeat(5)
			begin
				phase.raise_objection(this);

				fork
					apb_wr_00seq.start(envh.apb_th.apb_agth[0].aseqh);
				join
				#100;
					apb_wr_00seq.start(envh.apb_th.apb_agth[0].aseqh);

				phase.drop_objection(this);
			end
	endtask
endclass

//////////////////////// M S B ///////////////////////////////////////////////////////////////

class apb_cpha1_cpol1_msb_test extends spi_test;
	`uvm_component_utils(apb_cpha1_cpol1_msb_test)

	apb_cpha1_cpol1_wr_seqs1  apb_wr_11seq;	
	apb_cpha1_cpol1_rd_seqs1  apb_rd_11seq;

	function new(string name = "apb_cpha1_cpol1_msb_test",uvm_component parent);
		super.new(name,parent);	
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_wr_11seq = apb_cpha1_cpol1_wr_seqs1::type_id::create("apb_wr_11seq",this);
		apb_rd_11seq = apb_cpha1_cpol1_rd_seqs1::type_id::create("apb_rd_11seq",this);

	endfunction
	
	task run_phase(uvm_phase phase);
		repeat(5)
			begin
				phase.raise_objection(this);

				fork
					apb_wr_11seq.start(envh.apb_th.apb_agth[0].aseqh);
				join
				#100;
					apb_wr_11seq.start(envh.apb_th.apb_agth[0].aseqh);

				phase.drop_objection(this);
			end
	endtask
endclass

		
///////////////////////////// 1 0 /////////////////////////////////////////////////////////////	

class apb_cpha1_cpol0_msb_test extends spi_test;
	`uvm_component_utils(apb_cpha1_cpol0_msb_test)

	apb_cpha1_cpol0_wr_seqs1  apb_wr_10seq;	
	apb_cpha1_cpol0_rd_seqs1  apb_rd_10seq;

	function new(string name = "apb_cpha1_cpol0_msb_test",uvm_component parent);
		super.new(name,parent);	
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_wr_10seq = apb_cpha1_cpol0_wr_seqs1::type_id::create("apb_wr_10seq",this);
		apb_rd_10seq = apb_cpha1_cpol0_rd_seqs1::type_id::create("apb_rd_10seq",this);

	endfunction
	
	task run_phase(uvm_phase phase);
		repeat(5)
			begin
				phase.raise_objection(this);

				fork
					apb_wr_10seq.start(envh.apb_th.apb_agth[0].aseqh);
				join
				#100;
					apb_wr_10seq.start(envh.apb_th.apb_agth[0].aseqh);

				phase.drop_objection(this);
			end
	endtask
endclass
 //////////////////////////// 0 1 //////////////////////////////////////////////////////////////

class apb_cpha0_cpol1_msb_test extends spi_test;
	`uvm_component_utils(apb_cpha0_cpol1_msb_test)

	apb_cpha0_cpol1_wr_seqs1  apb_wr_01seq;	
	apb_cpha0_cpol1_rd_seqs1  apb_rd_01seq;

	function new(string name = "apb_cpha0_cpol1_msb_test",uvm_component parent);
		super.new(name,parent);	
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_wr_01seq = apb_cpha0_cpol1_wr_seqs1::type_id::create("apb_wr_01seq",this);
		apb_rd_01seq = apb_cpha0_cpol1_rd_seqs1::type_id::create("apb_rd_01seq",this);

	endfunction
	
	task run_phase(uvm_phase phase);
		repeat(5)
			begin
				phase.raise_objection(this);

				fork
					apb_wr_01seq.start(envh.apb_th.apb_agth[0].aseqh);
				join
				#100;
					apb_wr_01seq.start(envh.apb_th.apb_agth[0].aseqh);

				phase.drop_objection(this);
			end
	endtask
endclass

//////////////////////////////////////// 0 0 ///////////////////////////////////////////////////////

class apb_cpha0_cpol0_msb_test extends spi_test;
	`uvm_component_utils(apb_cpha0_cpol1_msb_test)

	apb_cpha0_cpol0_wr_seqs1  apb_wr_00seq;	
	apb_cpha0_cpol0_rd_seqs1  apb_rd_00seq;

	function new(string name = "apb_cpha0_cpol0_msb_test",uvm_component parent);
		super.new(name,parent);	
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		apb_wr_00seq = apb_cpha0_cpol0_wr_seqs1::type_id::create("apb_wr_00seq",this);
		apb_rd_00seq = apb_cpha0_cpol0_rd_seqs1::type_id::create("apb_rd_00seq",this);

	endfunction
	
	task run_phase(uvm_phase phase);
		repeat(5)
			begin
				phase.raise_objection(this);

				fork
					apb_wr_00seq.start(envh.apb_th.apb_agth[0].aseqh);
				join
				#100;
					apb_wr_00seq.start(envh.apb_th.apb_agth[0].aseqh);

				phase.drop_objection(this);
			end
	endtask
endclass


























