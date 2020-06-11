module Fibonacci_ALU_Decoder
(
input [11:0] FBC_Th_Value,  //That comes from the IR' 12 bits ontop of MUX2 in the simple MU0 design and after having been passed through the FORCE for FBC instruction - We ensure that we will always know the the th nu of the fib number we are looking for 
//input [15:0] FBCV_RAm_DataOut_B, that will go directly to the N>=2 calculator block
input [11:0] PC_Out,
input [15:0] N_PlusEq_Cal_Out, //This is the output from the Sum of the sum that produces the correct Fib Number for N>=2


input Fib_Check,
input Fetch, //I believe it won't be needed
input Exec1,
input Exec2,

output [15:0] FBCV_Reg,
output FBCV_Reg_En,

output FBCV_RAM_A_Wren,
output [15:0] FBCV_RAM_Data_A,
output [11:0] FBCV_RAM_Addr_A,
output [11:0] FBCV_RAM_Addr_B,

output FBCV_Pc_Cnt_En,
output FBCV_Pc_Reset, //That will be resposnible for setting the PC ouput to 0 after the condition has been satisfied - if reset is not available we will use DataIn with fixed 0s and Sload. 

//output PC_Add1, these bacame wires
//output PC_Add2, these became wires

output MUX_LS,
output MUX_RS,

output FBC_State //That will go into the State Machine indicating whether we should remain on EXEC1 or go to EXEC2 - this will enable us to remain in EXEC2 if needed and avoid remaing in EXEC1 in which we have numerous actions occuring.  
);


wire [11:0] PC_Add1= PC_Out + 1;
wire [11:0] PC_Add2= PC_Out + 2;


wire Base_Case_In_Check= (FBC_Th_Value==0) | (FBC_Th_Value==1); //Checking if we have N=0 or N=1  
wire [15:0] Base_Case= 1; //This is for N=0-fib(0) or N=1-fib(0)
wire Cond_Met= ((FBC_Th_Value==PC_Add2) | Base_Case_In_Check) & (Exec1 | Exec2) & Fib_Check; //Indicates if the value if it is one of the base cases or not and the value has been calculated - elimanates the possibility to save a value that should not be saved (E.g. Case of Fetch)


wire [15:0] Zeros=0;
wire [15:0] FBCV_Temp= Base_Case_In_Check ? Base_Case:N_PlusEq_Cal_Out; //That will be the result although this might keep changing (as a values) it will only be saved to the register(FBCV_Reg_En=1) only when the Cond_Met is satisfied see next line.
assign FBCV_Reg= Cond_Met ? FBCV_Temp:Zeros; //Not necessary - But only when the Cond_Met is satisfied this will output the correct result - all the other times it will output 0s.
assign FBCV_Reg_En= Cond_Met;


assign FBCV_RAM_A_Wren= ~Cond_Met; // It will keep storing the result of the Sum Block for N>=2 while the condition is not satisfied.
assign FBCV_RAM_Data_A= N_PlusEq_Cal_Out;
assign FBCV_RAM_Addr_A= PC_Add2; //This will be the address for storing the sum from the N>=2 calculator.
assign FBCV_RAM_Addr_B= PC_Add1;

assign FBCV_Pc_Cnt_En= ~Cond_Met & (Exec1 | Exec2) & Fib_Check; //When the condition is not satisfied keep counting - we added the last three condition in order to make sure that for example when we have Fetch it won't beacome 1
assign FBCV_Pc_Reset= Cond_Met; //When the condition is reset the counter to 0-this will enable us to have 0 in future calculations - since the PC in the beginning is initialized with value 0


assign MUX_LS= (PC_Add2==2);
assign MUX_RS= (PC_Out==0) | (PC_Out==1);

 
assign FBC_State=~Cond_Met&Fib_Check;//with that we make sure that we avoid when Cond_Met is not satisfied malfunction in the State Machine - e.g. not Fibonacci Instruction
endmodule
