module RND_DECODER
(
input [11:0] Loop_Value,
input RND_Check,
input Step_PC_Out,

input Exec1,
input Exec2,

output MUX_Loop_Select,
output PC_Cnt_En,
output PC_Sload,
output MUX_Initialv_Select,

output Step_PC_Cnt_En,
output Step_PC_Sload,
output RND_State,
output Sum_Y_Prime_Sload,
output MUX_Y_Select,
output Final_Sum_Sload
);

wire Cond_Met= Exec2 & RND_Check & (Loop_Value==1) & (Step_PC_Out==1);

//RND_PC
assign MUX_Loop_Select= Exec1;
assign PC_Cnt_En= ~Cond_Met & Step_PC_Out;
assign PC_Sload= (Exec1 & RND_Check) | (Exec2 & Cond_Met);
assign MUX_Initialv_Select= Exec2 & Cond_Met;

//STEP_PC
assign Step_PC_Cnt_En= (Step_PC_Out==0) & (RND_Check==1) & (Exec1 | Exec2);
assign Step_PC_Sload= ~Step_PC_Cnt_En | Cond_Met;

//Output Going to State Machine
assign RND_State= ~Cond_Met & RND_Check;

//Going to Sum/Y_Prime Block
assign Sum_Y_Prime_Sload= RND_Check & Exec2 & (Step_PC_Out==1);

//Going just out of ther Multiplication Block choosing between the Y=S or Y=Y_Prime
assign MUX_Y_Select= (Exec1 & RND_Check) | (Exec2 & RND_Check & (Loop_Value==8));

//Possibly going to a last register which will save the final value when the instruction has finished - the condition has been met 
assign Final_Sum_Sload= Cond_Met;

endmodule 

