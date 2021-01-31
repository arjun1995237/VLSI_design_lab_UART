//transmitter code working
module counter_tx(clk1,count,reset);
input reset,clk1;
output reg [3:0] count;
always@(posedge clk1)
begin
if (reset)
count<=4'b0000;
else
count<=count+1;
end
endmodule


module transmitter(data,start,clk1,done,reset,TX);
input [7:0] data;
input start,clk1,reset;
output reg done ,TX;
parameter idle=2'b00,start_bit=2'b01,shift=2'b10;
reg [1:0] present_state,next_state;

wire [3:0] count;
reg reset_ctr;
wire [8:0] data2;
assign data2={1'b1,data};
counter_tx DUT1(clk1,count,reset_ctr);
always @(present_state,start,count,data2)
begin
case(present_state)
idle:	begin
		TX=1;
		next_state=(start)?start_bit:idle;
		reset_ctr=1;
		end
start_bit:
		begin
		TX=0;
		done=0;
		reset_ctr=0;
		next_state=shift;
		end
shift:begin
		TX=data2[count-1];
		reset_ctr=0;
		next_state=(count!=4'b1001)?shift:idle;
		done=(count!=4'b1001)?0:((data2[count-1]==1)?1:0);
		end
default:
		begin
		next_state=idle;
		reset_ctr=0;
		done=0;
		TX=1;
		end
endcase
end
always@(posedge clk1)
begin
if(reset)
present_state<=idle;
else
present_state<=next_state;
end
endmodule

