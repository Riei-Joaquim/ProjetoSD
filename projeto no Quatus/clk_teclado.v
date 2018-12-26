module clk_teclado(clkin, clkout);
	input clkin;
	output clkout;
	reg clkout;
	reg [19:0]cont;
	initial begin
		clkout = 1'b0;
		cont = 20'b00000000000000000000;
	end
	
	always@(posedge clkin)begin
		if(cont == 20'b01111010000100100000)begin
			clkout <= ~clkout;
			cont = 20'b00000000000000000000;
		end
		else begin
			cont <= cont + 20'b00000000000000000001;
		end
	end
	
endmodule 