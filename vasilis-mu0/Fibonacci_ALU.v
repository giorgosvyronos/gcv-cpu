module Fibonacci_ALU
(
input [15:0] FBC_Th_Value,
input [15:0] FBCV_RAm_DataOut_B,
input [15:0] PC_Added_Out,

input Fetch,
input Exec1,
input Exec2,

output [15:0] FBCV_Reg,
output FBCV_Reg_En_A,

output FBCV_RAM_Wren,
output [15:0] FBCV_RAM_Data_A,
output [12:0] FBCV_RAM_Addr_A,
output [12:0] FBCV_RAM_Addr_B,

output Pc_Sload,
output Pc_Cnt_En,
output PC_DataIn

);

wire Base_Case_In_Check= (FBC_Th_Value==0) | (FBC_Th_Value==1); //Checking if we have N=0 or N=1  
wire [15:0] Base_Case = 1; //This is for N=0-fib(0) or N=1-fib(0)
wire Cond_Met= (FBC_Th_Value==PC_Added_Out) | Base_Case_Check; //Indicates if the value is one of the base cases or the value has been calculated 




 

