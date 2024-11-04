package sequencer;
    import uvm_pkg::*;
    import FIFO_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class fifo_sequencer extends uvm_sequencer #(fifo_seq_item);
        `uvm_component_utils(FIFO_sequencer);

        function new(string name="FIFO_sequencer",uvm_component parent = null);
            super.new(name,parent);
        endfunction:new
    endclass
endpackage