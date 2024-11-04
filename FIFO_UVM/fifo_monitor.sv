packagepkg;
    import uvm_pkg::*;
    import seq_item_pkg::*;
    `include "uvm_macros.svh"
    class fifo_monitor extends uvm_monitor ;
        `uvm_component_utils(monitor);
        virtual interface vif;
        uvm_analysis_port #(seq_item)ap;
        seq_itemseq_item;
        function new(string name="monitor",uvm_component parent=null);
            super.new(name,parent);
        endfunction
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
           ap=new("monitor_ap",this);
        endfunction
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
               seq_item=seq_item::type_id::create("monitor_seq_item");
                @(negedge vif.clk);

               seq_item.data_in =vif.data_in;
				monitor_seq_item.rst_n =vif.rst_n;
				monitor_seq_item.wr_en =vif.wr_en;
				monitor_seq_item.rd_en =vif.rd_en;
				monitor_seq_item.full =vif.full;
				monitor_seq_item.empty =vif.empty;
				monitor_seq_item.almostfull =vif.almostfull;
				
				monitor_seq_item.almostempty =vif.almostempty;
				monitor_seq_item.overflow =vif.overflow;
				monitor_seq_item.underflow =vif.underflow;
				monitor_seq_item.wr_ack =vif.wr_ack;
				monitor_seq_item.data_out =vif.data_out;
                monitor_ap.write(monitor_seq_item);
                `uvm_info("run_phase",FIFO_monitor_seq_item.convert2string(),UVM_HIGH);
            end
        endtask
    endclass
endpackage