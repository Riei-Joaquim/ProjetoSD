module main(clk,state_flag, bot_func, bot_enable, bot_pause, bot_reset, unidade, dezena, centena, milhar, linhas, colunas);
	output [6:0]state_flag;
	output [6:0]milhar, centena, dezena, unidade;
	input bot_func, bot_enable, bot_pause, bot_reset, clk;
	input [4:1]linhas;
	output [4:1]colunas;
	reg[6:0]state, proxstate;
	wire clkcont, fio_modo, fio_runner, fio_in_set, fio_reset;
	reg modoat, runner, in_set, reset;
	reg [13:0]num_in;
	reg [13:0]num_out;
	wire [13:0]fio_num_out, fio_num_in;
	wire [13:0]fio_set;
	reg [13:0]val_set;
	wire [13:0]temp_val;
	
	parameter[6:0] inicio = 7'b0000000,
					run = 7'b0000001,
					pause = 7'b0000010,
					set = 7'b0000011;
	
	assign fio_num_out = num_out;
	assign fio_set = val_set;
	assign fio_in_set = in_set;
	
	clk_state dut(.clkin(clk), .clkout(clkcont));
	setseg dut2(.num(fio_num_out), .Uconv(unidade), .Dconv(dezena), .Cconv(centena), .Mconv(milhar));
	cronometro dut3(.clk(clk), .num_at(fio_num_in), .runner(fio_runner), .modo(fio_modo),.limite(fio_set), .reset(fio_reset));
	controle_teclado dut11( .lin(linhas), .col(colunas), .clk(clk), .num_set(temp_val), .pset(in_set));
	
	assign fio_modo = modoat;
	assign fio_runner = runner;
	assign state_flag = state;
	assign fio_reset = reset;
	
	initial begin
		state = inicio;
		proxstate = inicio;
		reset = 1'b0;
		num_in = 14'b00000000000000;
		num_out = 14'b00000000000000;
		val_set = 14'b00000000000000;
		runner = 1'b0;
	end
	
	always@(posedge clkcont)begin
		state <= proxstate;
	end
	
	always@(bot_reset)begin
		if(!bot_reset)begin
			reset <= 1'b1;
		end
		else begin
			reset <= 1'b0;
		end
	end
	
	always@(*)begin
		case(state)
		inicio:begin
			modoat <= bot_func;
			runner <= 1'b0;
			in_set <= 1'b0;
			if(!bot_reset)begin
				proxstate <= inicio;
			end
			else if(!bot_enable)begin
				proxstate <= set; 
			end
			else 
				proxstate <= run;
		end
		run:begin
			runner <= 1'b1;
			in_set <= 1'b0;
			num_out <= fio_num_in;
			
			if(!bot_reset)begin
				proxstate <= inicio;
			end
			else if(!bot_pause)begin
				proxstate <= pause;
			end
			else if(!bot_enable)begin
				proxstate <= set;
			end
			else if(modoat != bot_func)begin
				proxstate <= inicio;
			end
			else begin
				proxstate <= run;
			end
		end
		pause:begin
			runner <= 1'b1;
			in_set <= 1'b0;
			if(!bot_reset)begin
				proxstate <= inicio;
			end
			else if(!bot_pause)begin
				proxstate <= run;
			end
			else if(modoat != bot_func)begin
				proxstate <= inicio;
			end
			else if(!bot_enable)begin
				proxstate <= set;
			end
			else begin
				proxstate <= pause;
			end
		end
		set:begin
			runner <= 1'b0;
			in_set <= 1'b1;
			num_out <= temp_val;
			val_set <= temp_val;
			
			if(modoat != bot_func)begin
				modoat <= bot_func;
			end
			if(!bot_reset)begin
				proxstate <= inicio;
			end
			else if(bot_enable)begin
				proxstate <= run;
			end
			else begin
				proxstate <= set;
			end
		end
		endcase
	end
	
endmodule 