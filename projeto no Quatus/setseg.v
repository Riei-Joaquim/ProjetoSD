module setseg(num, Uconv, Dconv, Cconv, Mconv);
	output [6:0] Uconv;
	output [6:0] Dconv;
	output [6:0] Cconv;
	output [6:0] Mconv;
	input [13:0]num;
	
	parameter[3:0] num0 = 4'b0000,
						num1 = 4'b0001,
						num2 = 4'b0010,
						num3 = 4'b0011,
						num4 = 4'b0100,
						num5 = 4'b0101,
						num6 = 4'b0110,
						num7 = 4'b0111,
						num8 = 4'b1000,
						num9 = 4'b1001;
						
	parameter[6:0] conver0 = 7'b0000001,
						conver1 = 7'b1001111,
						conver2 = 7'b0010010,
						conver3 = 7'b0000110,
						conver4 = 7'b1001100,
						conver5 = 7'b0100100,
						conver6 = 7'b0100000,
						conver7 = 7'b0001111,
						conver8 = 7'b0000000,
						conver9 = 7'b0000100;				
	reg [6:0] Uconv;
	reg [6:0] Dconv;
	reg [6:0] Cconv;
	reg [6:0] Mconv;
	
	//unidade
	always@(num) begin
		if(num%10 == num0)
			Uconv <= conver0;
		else if(num%10 == num1)
			Uconv <= conver1;
		else if(num%10 == num2)
			Uconv <= conver2;
		else if(num%10 == num3)
			Uconv <= conver3;
		else if(num%10 == num4)
			Uconv <= conver4;
		else if(num%10 == num5)
			Uconv <= conver5;
		else if(num%10 == num6)
			Uconv <= conver6;
		else if(num%10 == num7)
			Uconv <= conver7;
		else if(num%10 == num8)
			Uconv <= conver8;
		else if(num%10 == num9)
			Uconv <= conver9;
	end
	
	//dezena
	always@(num) begin
		if((num%100)/10 == num0)
			Dconv <= conver0;
		else if((num%100)/10 == num1)
			Dconv <= conver1;
		else if((num%100)/10 == num2)
			Dconv <= conver2;
		else if((num%100)/10 == num3)
			Dconv <= conver3;
		else if((num%100)/10 == num4)
			Dconv <= conver4;
		else if((num%100)/10 == num5)
			Dconv <= conver5;
		else if((num%100)/10 == num6)
			Dconv <= conver6;
		else if((num%100)/10 == num7)
			Dconv <= conver7;
		else if((num%100)/10 == num8)
			Dconv <= conver8;
		else if((num%100)/10 == num9)
			Dconv <= conver9;
	end
	
	//centena
	always@(num) begin
		if((num%1000)/100 == num0)
			Cconv <= conver0;
		else if((num%1000)/100 == num1)
			Cconv <= conver1;
		else if((num%1000)/100 == num2)
			Cconv <= conver2;
		else if((num%1000)/100 == num3)
			Cconv <= conver3;
		else if((num%1000)/100 == num4)
			Cconv <= conver4;
		else if((num%1000)/100 == num5)
			Cconv <= conver5;
		else if((num%1000)/100 == num6)
			Cconv <= conver6;
		else if((num%1000)/100 == num7)
			Cconv <= conver7;
		else if((num%1000)/100 == num8)
			Cconv <= conver8;
		else if((num%1000)/100 == num9)
			Cconv <= conver9;
	end
	
	//milhar
	always@(num) begin
		if(num/1000 == num0)
			Mconv <= conver0;
		else if(num/1000 == num1)
			Mconv <= conver1;
		else if(num/1000 == num2)
			Mconv <= conver2;
		else if(num/1000 == num3)
			Mconv <= conver3;
		else if(num/1000 == num4)
			Mconv <= conver4;
		else if(num/1000 == num5)
			Mconv <= conver5;
		else if(num/1000 == num6)
			Mconv <= conver6;
		else if(num/1000 == num7)
			Mconv <= conver7;
		else if(num/1000 == num8)
			Mconv <= conver8;
		else if(num/1000 == num9)
			Mconv <= conver9;
	end
	
endmodule
