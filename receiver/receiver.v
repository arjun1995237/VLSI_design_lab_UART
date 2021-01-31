//---------working-----
//Note: clk1 is 16xBaud,
//LSB is send first followed by MSB
module counter_rx(clr_count,clk1,count,bit_count);
input clr_count,clk1;
output reg [3:0]count,bit_count;
always@(posedge clk1)
begin
if (clr_count)
	begin
	count<=4'b0000;
	bit_count<=4'b0000;
	end
else if(count==4'b0111)
begin
	bit_count<=bit_count+4'b0001;
	count<=count+4'b0001;
	end
else
	count<=count+4'b0001;
end
endmodule

module receiver (clk1,RX,reset,valid_frame,dout);
input clk1,RX,reset;
output reg valid_frame;
output reg [7:0] dout;
reg [1:0] present_state,next_state;
parameter idle=2'b00,glitch=2'b01,sample=2'b10,check=2'b11;
wire [3:0]count,bit_count;
reg clr_count;
reg [9:0]temp;

counter_rx DUT2(clr_count,clk1,count,bit_count);
always@(bit_count)
begin
temp<={RX,temp[9:1]};
end

always@(posedge valid_frame)
begin
dout<=temp[8:1];
end
always@(present_state,RX,count,bit_count,temp)
begin
case(present_state)
idle:
		begin
		next_state=(RX)?idle:glitch;
		valid_frame=(RX)?1'b1:1'b0;
		clr_count=1;
		end
glitch:
		begin
		next_state=(RX)?idle:((count!=4'b0111)?glitch:sample);
		clr_count=0;
		valid_frame=0;
		end
sample:
		begin
		next_state=(bit_count!=4'b1010)?sample:check;
		valid_frame=0;
		clr_count=0;
		end
check:
		begin
		next_state=idle;
		
		valid_frame=(temp[9]==1)?1'b1:1'b0;
		
		clr_count=0;
		end
default:
begin
		next_state=idle;
		
		valid_frame=0;
		clr_count=1;
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
