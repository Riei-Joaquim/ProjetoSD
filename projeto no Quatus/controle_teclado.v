module controle_teclado(lin, col, clk, num_set, pset);
	input clk;
	input [4:1]lin;
	input pset;
	output [4:1]col;
	output [13:0]num_set;
	reg [13:0]num_set;
	reg [13:0]num_in;
	wire salva;
	wire [3:0]num_temp;
	
	initial begin
		num_in <= 14'b00000000000000;
		num_set <= 14'b00000000000000;
	end
	
	teclado dut9 (.linhas(lin), .colunas(col), .clk(clk), .num_sel(num_temp), .salve(salva));
	
	always@(negedge salva)begin
		if(num_temp == 4'b1100 && pset)begin
			num_set <= num_in;
			num_in <= 14'b00000000000000;
		end
		else begin
			if(pset)begin
				num_in <= (num_in*10 + num_temp)%10000;
			end
		end
	end
endmodule 