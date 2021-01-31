
`timescale 1 ns/1 ps
module test_divider;
reg t_clk;
wire t_clk1;
clk_divider dut(.clk(t_clk),.clk1(t_clk1));
initial 
begin
t_clk=0;

end
always
begin
#10 t_clk<=~t_clk;

end

initial

#500000000 $finish;
 initial begin
    //dump waveform
    $dumpfile("dump.vcd"); $dumpvars;
  end

endmodule
