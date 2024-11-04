package seq_item;
    import uvm_pkg::*;
    import FIFO_shared_pkg::*;
    `include "uvm_macros.svh"

    class fifo_seq_item extends uvm_sequence_item;
        `uvm_object_utils(fifo_seq_item);
        rand logic [FIFO_WIDTH-1:0] data_in;
        rand logic rst_n, wr_en, rd_en;
		logic [FIFO_WIDTH-1:0] data_out;
		logic wr_ack, overflow;
		logic full, empty, almostfull, almostempty, underflow;

        int wr_en_on_dist=70;
        int rd_en_on_dist=30;

        constraint reset_c{
            rst_n dist {0:=5,1:=95};
        }

        constraint wr_en_c{
            wr_en dist{1:= wr_en_on_dist, 0:= 100- wr_en_on_dist}
        }

        constraint rd_en_c{
            rd_en dist {1:= rd_en_on_dist , 0:=100-rd_en_on_dist}
        }

        function new(string name="fifo_seq_item");
            super.new(name);
        endfunction

        virtual function string convert2string();
			return $sformatf(" %s  reset=%0b , din%0h , rd_en=%0b, wr_en=%0b , data_out=%0h wr_ack=%0b overflow=%0b full=%0b
			 empty=0%b almostfull=%0b almostempty=%0b underflow=0%b"
			 ,super.convert2string(),rst_n, data_in, rd_en, wr_en, data_out, wr_ack, overflow, full, empty, almostfull
			 ,almostempty,underflow);
		endfunction: convert2string

		virtual function string convert2string_stimulus();
			return $sformatf("reset=%0b , din%0h , rd_en=%0b, wr_en=%0b",rst_n,data_in, rd_en, wr_en);
		endfunction: convert2string_stimulus		

        
    endclass
endpackage