module clk_state(clkin, clkout);
	input clkin;
	output clkout;
	reg clkout;
	reg [23:0]cont;
	initial begin
		clkout = 1'b0;
		cont = 24'b000000000000000000000000;
	end
	
	always@(posedge clkin)begin
		if(cont == 24'b010011000100101101000000)begin
			clkout <= ~clkout;
			cont = 24'b000000000000000000000000;
		end
		else begin
			cont <= cont + 24'b000000000000000000000001;
		end
	end
	
endmodule 