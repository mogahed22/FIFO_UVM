package FIFO_agent_pkg;
    import uvm_pkg::*;
	import FIFO_seq_item_pkg::*;
	import FIFO_config_pkg::*;
	import FIFO_driver_pkg::*;
	import FIFO_monitor_pkg::*;
	import FIFO_sequencer_pkg::*;
	`include "uvm_macros.svh"

    class fifo_agent extends uvm_agent;
        `uvm_component_utils(fifo_agent);
        fifo_config_obg agent_cfg;
        fifo_driver agent_driver;
        fifo_monitor agent_monitor;
        fifo_sequencer agent_sqr;
        uvm_analysis_port #(fifo_seq_item) agent_ap;

        function new(string name="fifo_agent",uvm_component parent=null);
            super.new(name,parent);
        endfunction 

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            FIFO_agent_cfg=FIFO_config_obj::type_id::create("FIFO_agent_cfg",this);
			if(! uvm_config_db #(FIFO_config_obj)::get(this, "", "FIFO_CFG",FIFO_agent_cfg) )
				`uvm_fatal("build_phase", "get of FIFO cfg failed in agent");
			if(! uvm_config_db #(uvm_active_passive_enum)::get(this, "", "FIFO_agent_type",FIFO_agent_cfg.active) )
				`uvm_fatal("build_phase", "get of FIFO agent type failed in agent");
			if(FIFO_agent_cfg.active==UVM_ACTIVE) begin
				FIFO_agent_driver= FIFO_driver::type_id::create("FIFO_agent_driver",this);
				FIFO_agent_sqr= FIFO_sequencer::type_id::create("FIFO_agent_sqr",this);
			end
			FIFO_agent_monitor= FIFO_monitor::type_id::create("FIFO_agent_monitor",this);
			agent_ap=new("agent_ap",this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            if(FIFO_agent_cfg.active==UVM_ACTIVE) begin
				FIFO_agent_driver.FIFO_driver_vif=FIFO_agent_cfg.FIFO_config_vif;
				FIFO_agent_driver.seq_item_port.connect(FIFO_agent_sqr.seq_item_export);
			end
			FIFO_agent_monitor.FIFO_monitor_vif=FIFO_agent_cfg.FIFO_config_vif;
			FIFO_agent_monitor.monitor_ap.connect(agent_ap);
        endfunction
    endclass
endpackage