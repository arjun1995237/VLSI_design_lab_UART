//generates 1 second-high and 1 second- low 
//working in fpga-DE0 nano
module clk_divider(clk,clk1,reset);
input clk,reset;
output reg clk1;


reg [25:0] count=0;
always@(posedge clk)
begin
if (reset)
begin
clk1<=0;
count<=0;
end
 else if (count==13/*217*/)
begin

count<=0;
clk1<=~clk1;
end
else
count<=count+1;
end
endmodule
