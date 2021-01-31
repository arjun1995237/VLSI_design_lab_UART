`timescale 1 ns/1 ps
module testbench;
reg [7:0] data;
reg start,clk1,reset;
wire TX,done;
transmitter DUT2 (data,start,clk1,done,reset,TX);
initial
begin 
clk1=0;
reset=0;
# 10 data=8'b10101100;
#25 start=1;
#40 start=0;
#100 data=8'b11101011;
#120 start=1;
#40 start=0;
end
 always
 #10 clk1=~clk1;
 initial
 #600 $finish;
 endmodule 