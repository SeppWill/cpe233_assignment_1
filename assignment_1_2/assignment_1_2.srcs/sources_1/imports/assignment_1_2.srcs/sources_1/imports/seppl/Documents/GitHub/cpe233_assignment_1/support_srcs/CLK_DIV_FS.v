
//-----------------------------------------------------------------------
//-- Module to divide the clock 
//-----------------------------------------------------------------------
module clk_div (  input clk,
                  output sclk);

  integer MAX_COUNT = 6000000; // 2200; 
  integer div_cnt =0;
  reg tmp_clk=0; 

   always @ (posedge clk)              
   begin
         if (div_cnt == MAX_COUNT) 
         begin
            tmp_clk = ~tmp_clk; 
            div_cnt = 0;
         end else
            div_cnt = div_cnt + 1;  
   end 
   assign sclk = tmp_clk; 
endmodule
