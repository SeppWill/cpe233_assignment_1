module cntr_udclr_nb(clk, clr, up, ld, D, count, rco);
	parameter n = 8;
	input   clk, clr, up, ld;
	input   [n-1:0] D;
	output  reg [n-1:0] count;
	output  reg rco;
	
	always @ (posedge clr)
	begin
	   if (clr == 0)
	       count <= 0;
	end

	always @(posedge clk)
	begin
		if (clr == 1)       // asynch reset count <= 0;
		  count <= 0;
		else if (ld == 1)   // load new value count <= D;
		  count <= D;
		else if (up == 1)   // count up (increment) count <= count + 1;
		  count <= count + 1;
		else if (up == 0)
		  count <= count;
	end

	//- handles the RCO, which is direction dependent

	always @(count, up)
	begin
		if ( up == 1 && &count == 1'b1) rco = 1'b1;
		//else if (up == 0 && |count == 1'b1) rco = 1'b1;
		else
			rco = 1'b0;

	end
endmodule


