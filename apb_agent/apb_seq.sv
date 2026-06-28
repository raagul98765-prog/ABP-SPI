class apb_sequence extends uvm_sequence #(apb_xtn);
	`uvm_object_utils(apb_sequence)

	function new(string name = "apb_sequence");
		super.new(name);
	endfunction

endclass

//cpha=1 and cpol=1
class apb_cpha1_cpol1_wr_seqs extends apb_sequence;
`uvm_object_utils(apb_cpha1_cpol1_wr_seqs)

	function new(string name = "apb_cpha1_cpol1_wr_seqs");
	super.new(name);
	endfunction

	task body();
//	super.body();
	
	req = apb_xtn::type_id::create("req");
	
/*	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR! == 101;});
	finish_item(req);*/

	$display("inside sequence");

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b000; PWDATA == 8'b1111_1111;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b001; PWDATA == 8'b0001_1011;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b010; PWDATA == 8'b00000000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b101;});
	finish_item(req);
	
	endtask
endclass

class apb_cpha1_cpol1_rd_seqs extends apb_sequence;
`uvm_object_utils(apb_cpha1_cpol1_rd_seqs)



	function new(string name = "apb_cpha1_cpol1_rd_seqs");
	super.new(name);
	endfunction
	
	task body();
//	super.body();
	req = apb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR == 3'b101;});
	finish_item(req);

	endtask
endclass

//cpha=1 and cpol=0
class apb_cpha1_cpol0_wr_seqs extends apb_sequence;
`uvm_object_utils(apb_cpha1_cpol0_wr_seqs)

	function new(string name = "apb_cpha1_cpol0_wr_seqs");
	super.new(name);
	endfunction

	task body();
	super.body();

	req = apb_xtn::type_id::create("req");
	
/*	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR! == 101;});
	finish_item(req);*/

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b000; PWDATA == 8'b1111_1001;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b001; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b101; PWDATA == 8'b1010_1010;});
	finish_item(req);

	endtask
endclass

class apb_cpha1_cpol0_rd_seqs extends apb_sequence;
`uvm_object_utils(apb_cpha1_cpol0_rd_seqs)

	function new(string name = "apb_cpha1_cpol0_rd_seqs");
	super.new(name);
	endfunction
	
	task body();
	super.body();
	
	req = apb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR == 101;}); 
	finish_item(req);
	endtask
endclass


//cpha=0 and cpol=1
class apb_cpha0_cpol1_wr_seqs extends apb_sequence;
`uvm_object_utils(apb_cpha0_cpol1_wr_seqs)

	function new(string name = "apb_cpha0_cpol1_wr_seqs");
	super.new(name);
	endfunction

	task body();
	super.body();
	
	req = apb_xtn::type_id::create("req");
	
/*	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR! == 101;});
	finish_item(req);*/

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b000; PWDATA == 8'b0001_0101;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b001; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b101; PWDATA == 8'b1010_1010;});
	finish_item(req);

	endtask
endclass

class apb_cpha0_cpol1_rd_seqs extends apb_sequence;
`uvm_object_utils(apb_cpha0_cpol1_rd_seqs)

	function new(string name = "apb_cpha0_cpol1_rd_seqs");
	super.new(name);
	endfunction
	
	task body();
	super.body();

	req = apb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR == 101;});
	finish_item(req);
	endtask
endclass

//cpha=0 and cpol=0
class apb_cpha0_cpol0_wr_seqs extends apb_sequence;
`uvm_object_utils(apb_cpha0_cpol0_wr_seqs)

	function new(string name = "apb_cpha0_cpol0_wr_seqs");
	super.new(name);
	endfunction

	task body();
	super.body();
	
	req = apb_xtn::type_id::create("req");
	
/*	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR! == 101;});
	finish_item(req);*/

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b000; PWDATA == 8'b0001_0001;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b001; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b101; PWDATA == 8'b1010_1010;});
	finish_item(req);

	endtask
endclass

class apb_cpha0_cpol0_rd_seqs extends apb_sequence;
`uvm_object_utils(apb_cpha0_cpol0_rd_seqs)

	function new(string name = "apb_cpha0_cpol0_rd_seqs");
	super.new(name);
	endfunction
	
	task body();
	super.body();

	req = apb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR == 101;});
	finish_item(req);
	endtask
endclass


/////////////////////////////////////////////////////////////////////////////////////////MSB///////////////////////////////////////////////////////////////
//cpha=1 cpol=1	
class apb_cpha1_cpol1_wr_seqs1 extends apb_sequence;
`uvm_object_utils(apb_cpha1_cpol1_wr_seqs1)

	function new(string name = "apb_cpha1_cpol1_wr_seqs1");
	super.new(name);
	endfunction

	task body();
	super.body();
	
	req = apb_xtn::type_id::create("req");
	
/*	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR! == 101;});
	finish_item(req);*/

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b000; PWDATA == 8'b0001_1100;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b001; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b101; PWDATA == 8'b1010_1010;});
	finish_item(req);
	
	endtask
endclass

class apb_cpha1_cpol1_rd_seqs1 extends apb_sequence;
`uvm_object_utils(apb_cpha1_cpol1_rd_seqs1)

	function new(string name = "apb_cpha1_cpol1_rd_seqs1");
	super.new(name);
	endfunction
	
	task body();
	super.body();
	req = apb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR == 101;});
	finish_item(req);

	endtask
endclass


//cpha=1 and cpol=0
class apb_cpha1_cpol0_wr_seqs1 extends apb_sequence;
`uvm_object_utils(apb_cpha1_cpol0_wr_seqs1)

	function new(string name = "apb_cpha1_cpol0_wr_seqs1");
	super.new(name);
	endfunction

	task body();
	super.body();

	req = apb_xtn::type_id::create("req");
	
/*	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR! == 101;});
	finish_item(req);*/

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b000; PWDATA == 8'b0001_1000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b001; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b101; PWDATA == 8'b1010_1010;});
	finish_item(req);

	endtask
endclass

class apb_cpha1_cpol0_rd_seqs1 extends apb_sequence;
`uvm_object_utils(apb_cpha1_cpol0_rd_seqs1)

	function new(string name = "apb_cpha1_cpol0_rd_seqs1");
	super.new(name);
	endfunction
	
	task body();
	super.body();
	
	req = apb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR == 101;});
	finish_item(req);
	endtask
endclass
///////// 0///////////1
class apb_cpha0_cpol1_wr_seqs1 extends apb_sequence;
`uvm_object_utils(apb_cpha0_cpol1_wr_seqs1)

	function new(string name = "apb_cpha0_cpol1_wr_seqs1");
	super.new(name);
	endfunction

	task body();
	super.body();

	req = apb_xtn::type_id::create("req");
	
/*	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR! == 101;});
	finish_item(req);*/

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b000; PWDATA == 8'b0001_0100;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b001; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b101; PWDATA == 8'b1010_1010;});
	finish_item(req);

	endtask
endclass
class apb_cpha0_cpol1_rd_seqs1 extends apb_sequence;
`uvm_object_utils(apb_cpha0_cpol1_rd_seqs1)

	function new(string name = "apb_cpha0_cpol1_rd_seqs1");
	super.new(name);
	endfunction
	
	task body();
	super.body();
	
	req = apb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR == 101;});
	finish_item(req);
	endtask
endclass
/////////////////////////////////////0       0 /////////
class apb_cpha0_cpol0_wr_seqs1 extends apb_sequence;
`uvm_object_utils(apb_cpha0_cpol0_wr_seqs1)

	function new(string name = "apb_cpha0_cpol0_wr_seqs1");
	super.new(name);
	endfunction

	task body();
	super.body();

	req = apb_xtn::type_id::create("req");
	
/*	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR! == 101;});
	finish_item(req);*/

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b000; PWDATA == 8'b0001_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b001; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0000;});
	finish_item(req);

	start_item(req);
	assert(req.randomize() with{PRESETn == 1'b1; PWRITE == 1'b1; PADDR == 3'b101; PWDATA == 8'b1010_1010;});
	finish_item(req);

	endtask
endclass
class apb_cpha0_cpol0_rd_seqs1 extends apb_sequence;
`uvm_object_utils(apb_cpha0_cpol0_rd_seqs1)

	function new(string name = "apb_cpha0_cpol0_rd_seqs1");
	super.new(name);
	endfunction
	
	task body();
	super.body();
	
	req = apb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize() with{PRESETn == 0; PWRITE == 0; PADDR == 101;});
	finish_item(req);
	endtask

endclass















