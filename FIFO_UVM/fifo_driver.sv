package FIFO_driver;
    import uvm_pkg::*;
    import FIFO_seq_item_pkg::*;
    `include "uvm_macros.svh"
    class fifo_driver extends uvm_driver #(fifo_seq_item);
        `uvm_component_utils(fifo_driver);
        virtual fifo_interface vif;
        fifo_seq_item stim_seq_item;
        function new(string name = "fifo_driver",uvm_component parent=null );
            super.new(name,parent);
        endfunction
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                stim_seq_item=fifo_seq_item::type_id::create("stim_seq_item");
                seq_item_port.get_next_itme(stim_seq_item);
                vif.rst_n= stim_seq_item.rst_n;
                vif.data_in=stim_seq_item.data_in;
                vif.wr_en=stim_seq_item.wr_en;
                vif.rd_en=stim_seq_item.rd_en;
                @(negedge vif.clk);
                seq_item_port.item_done();
               `uvm_info("run_phase", stim_seq_item.convert2string_stimulus(), UVM_HIGH);
            end
        endtask
    endclass
endpackage