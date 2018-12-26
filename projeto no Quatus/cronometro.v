module cronometro(clk, num_at, runner, modo, limite, reset);
	input clk, modo, runner, reset;
	input [13:0]limite;
	output [14:0]num_at;
	reg [13:0]num_at;
	reg[13:0]max;
	reg [6:0]state, proxstate;
	wire clkcont;
	wire [13:0]fio_num_at;
	initial begin
		state = set;
		proxstate = set;
	end
	
	parameter[6:0] set = 7'b0000000,
					desc = 7'b0000001,
					 cres = 7'b0000010;
					 
	assign fio_num_at = num_at;
	
	clk_contador dut( .clkin(clk), .clkout(clkcont));
	setseg dut1(.num(fio_num_at), .Uconv(unidade), .Dconv(dezena), .Cconv(centena), .Mconv(milhar));
	
	always@(negedge clkcont)begin
		state <= proxstate;
		case(state)
		set:begin
			if(!modo)begin
				num_at <= 14'b00000000000000;
				max <= limite;
			end
			else begin
				num_at <= limite;
				max <= 14'b00000000000000;
			end
		end
		desc:begin
			if(num_at > max)begin
				num_at <= num_at - 14'b00000000000001;
			end
		end
		cres:begin
			if(num_at < max)begin
				num_at <= num_at + 14'b00000000000001;
			end
		end
		endcase
	end	
			 
	always@(*)begin
		case(state)
		set:begin
			if(runner && !reset)begin
				if(!modo)begin
					proxstate <= cres;
				end
				else begin
					proxstate <= desc;
				end
			end
			else begin
				proxstate <= set;
			end
		end
		desc:begin
			if(!runner || reset)begin
				proxstate <= set;
			end
			else if(!modo)begin
				proxstate <= set;
			end
			else begin
				proxstate <= desc;
			end
		end
		cres:begin
			if(!runner || reset)begin
				proxstate <= set;
			end
			else if(modo)begin
				proxstate <= set;
			end
			else begin
				proxstate <= cres;
			end
		end
		endcase
	end
endmodule 