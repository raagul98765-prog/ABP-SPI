class spi_seq extends uvm_sequence#(spi_xtn);
	`uvm_object_utils(spi_seq)

	function new(string name = "spi_seq");
		super.new(name);
	endfunction

endclass

class spi_cpha_cpol_seqs extends spi_seq;
	`uvm_object_utils(spi_cpha_cpol_seqs)

	function new(string name = "spi_cpha_cpol_seqs");
		super.new(name);
	endfunction

	task body();
		begin
			req = spi_xtn::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {miso == 8'b1111_1111;});
			finish_item(req);
		end
	endtask
endclass
