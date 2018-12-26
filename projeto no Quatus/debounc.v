module debounc(clk, bot, bot_trat);
	input clk, bot;
	output bot_trat;
	reg bot_trat;
	
	parameter[6:0]alto = 7'b0000000,
					temp = 7'b0000001,
					baixo = 7'b0000010;
					
	reg [6:0]state, proxstate;
	reg [19:0]cont;
	wire clk_d;
	
	assign clk_flag = clk_d;
	
	initial begin	
		state = alto;
		proxstate = alto;
		cont = 20'b00000000000000000000;
		bot_trat = 1'b1;
	end
	
	always@(posedge clk)begin
		state <= proxstate;
		case(state)
		alto:begin
			cont = 20'b00000000000000000000;
		end
		temp:begin
			cont <= cont +20'b00000000000000000001;
		end
		baixo:begin
			cont <= 20'b00000000000000000000;
		end
		endcase
	end
	
	always@(*)begin
		case(state)
		alto:begin
			bot_trat <= 1'b1;
			
			if(!bot) begin
				proxstate <= temp;
			end
			else begin
				proxstate <= alto;
			end
		end
		temp:begin
			if(cont == 20'b01111010000100100000)begin
				if(bot_trat)begin
					if(!bot)begin
						proxstate <= baixo;
					end
					else begin
						proxstate <= alto;
					end
				end
				else begin
					if(bot)begin
						proxstate <= alto;
					end
					else begin
						proxstate <= baixo;
					end
				end
			end
			else begin
				proxstate <= temp;
			end
		end
		baixo:begin
			bot_trat <= 1'b0;
			
			if(bot) begin
				proxstate <= temp;
			end
			else begin
				proxstate <= baixo;
			end
		end
		endcase
	end
endmodule 