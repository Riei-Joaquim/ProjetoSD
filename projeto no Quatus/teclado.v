module teclado(linhas, colunas, clk, num_sel, salve);
	input [4:1]linhas;
	output [4:1]colunas;
	reg [4:1]colunas;
	output salve;
	reg salve;
	input clk;
	output[3:0]num_sel;
	reg [3:0]num_sel;
	wire [4:1]lin_debounc;
	reg[1:0]proxstate, state;
	reg [19:0]cont;
	wire clk_state;
	
	debounc dut5( .clk(clk), .bot(linhas[4]), .bot_trat(lin_debounc[4]));
	debounc dut6( .clk(clk), .bot(linhas[3]), .bot_trat(lin_debounc[3]));
	debounc dut7( .clk(clk), .bot(linhas[2]), .bot_trat(lin_debounc[2]));
	debounc dut8( .clk(clk), .bot(linhas[1]), .bot_trat(lin_debounc[1]));
	clk_teclado dut9( .clkin(clk), .clkout(clk_state));
	
	parameter[1:0] coluna1 = 2'b01,
				   coluna2 = 2'b10,
				   coluna3 = 2'b11;
	initial begin
		state = coluna1;
		proxstate = coluna2;
		num_sel = 4'b0000;
		salve = 1'b0;
	end
	
	always@(posedge clk_state)begin
		state <= proxstate;
	end
	
	always@(posedge clk)begin
		case(state)
		coluna1:begin
			colunas <= 4'b1101;
			case(lin_debounc)
			4'b0111:begin
				proxstate <= coluna1;
				salve <= 1'b0;
			end
			4'b1011:begin
				proxstate <= coluna1;
				num_sel <= 4'b0111;
				salve <= 1'b1;
			end
			4'b1101:begin
				proxstate <= coluna1;
				num_sel <= 4'b0100;
				salve <= 1'b1;
			end
			4'b1110:begin
				proxstate <= coluna1;
				num_sel <= 4'b0001;
				salve <= 1'b1;
			end
			default begin
				proxstate <= coluna2;
				salve <= 1'b0;
			end
			endcase
		end
		coluna2:begin
			colunas <= 4'b1011;
			
			case(lin_debounc)
			4'b0111:begin
				proxstate <= coluna2;
				num_sel <= 4'b0000;
				salve <= 1'b1;
			end
			4'b1011:begin
				proxstate <= coluna2;
				num_sel <= 4'b1000;
				salve <= 1'b1;
			end
			4'b1101:begin
				proxstate <= coluna2;
				num_sel <= 4'b0101;
				salve <= 1'b1;
			end
			4'b1110:begin
				proxstate <= coluna2;
				num_sel <= 4'b0010;
				salve <= 1'b1;
			end
			default begin
				proxstate <= coluna3;
				salve <= 1'b0;
			end
			endcase
		end
		coluna3:begin
			colunas <= 4'b0111;
			
			case(lin_debounc)
			4'b0111:begin
				proxstate <= coluna3;
				num_sel <= 4'b1100;
				salve <= 1'b1;
			end
			4'b1011:begin
				proxstate <= coluna3;
				num_sel <= 4'b1001;
				salve <= 1'b1;
			end
			4'b1101:begin
				proxstate <= coluna3;
				num_sel <= 4'b0110;
				salve <= 1'b1;
			end
			4'b1110:begin
				proxstate <= coluna3;
				num_sel <= 4'b0011;
				salve <= 1'b1;
			end
			default begin
				proxstate <= coluna1;
				salve <= 1'b0;
			end
			endcase
		end
		endcase
	end
endmodule 