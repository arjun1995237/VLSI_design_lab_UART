`timescale 1 ns/1 ps
module testbench;
reg rx,clk1,reset;
wire valid_frame;
wire [7:0] d_out;
receiver dut3 (clk1,rx,reset,valid_frame,d_out);
initial
begin
clk1=0;
reset=0;
rx=1;

end

always
#10 clk1=~clk1;

initial
begin
#400
rx=0;
#320

rx=1;
#320

rx=0;
#320

rx=1;
#320

rx=0;
#320

rx=1;
#320

rx=1;
#320
rx=1;
#320

rx=0;
#320
rx=1;
#320

rx=1;
#320

#400
rx=0;
#320

rx=1;
#320

rx=1;
#320

rx=1;
#320

rx=1;
#320

rx=0;
#320

rx=0;
#320
rx=0;
#320

rx=0;
#320
rx=1;
#320

rx=1;
#320
$finish;

end

endmodule


