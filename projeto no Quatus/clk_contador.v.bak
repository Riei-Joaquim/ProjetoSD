module clk_contador(clkin, clkout);
	input clkin;
	output clkout;
	reg clkout;
	reg [24:0]cont;
	initial begin
		clkout = 1'b0;
		cont = 25'b0000000000000000000000000;
	end
	
	always@(posedge clkin)begin
		if(cont == 25'b1011111010111100001000000)begin
			clkout <= ~clkout;
			cont = 25'b0000000000000000000000000;
		end
		else begin
			cont <= cont +25'b0000000000000000000000001;
		end
	end
	
endmodule 