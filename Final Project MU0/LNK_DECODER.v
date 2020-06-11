module LNK_DECODER
(
input Exec1,
input Exec2,
input LNK_Check,
input [15:0] LNK_Data_A,
input [11:0] Last_Address,
input [11:0] LNK_Data_B,
input PC_N_To_Find_Out,
input [15:0] N_To_Find_Out,

output Keep_Last_Address_Sload,
output MUX_Address_Sel_A_B_AWren,
output MUX_Initial_Addr_Select,
output PC_N_To_Find_Cnt_En,
output PC_N_To_Find_Sload,
output N_To_Find_Reg_Sload,
output [11:0] LNK_Address_Result,
output LNK_Result_Reg_En,
output LNK_State
);

wire Value_Found= Exec2 & (LNK_Data_A==N_To_Find_Out) & LNK_Check;
wire Null_Found= Exec2 & (LNK_Data_B==0) & LNK_Check;
wire Cond_Met= Exec2 & (Value_Found | Null_Found);
wire [11:0] Zeroes=0; 

//Output going to the State Machine 
assign LNK_State= ~Cond_Met & LNK_Check;

//Outputs to Supported Register that could contain the result
assign LNK_Address_Result= Value_Found ? Last_Address:Zeroes;
assign LNK_Result_Reg_En= Value_Found;

//Going to Keep_Last_Address_Reg
assign Keep_Last_Address_Sload= (Exec1 | Exec2) & LNK_Check;

//Going to the MUXs controlling whether we have an LNK or a FBC instruction
assign MUX_Address_Sel_A_B_AWren= (Exec1 | Exec2) & LNK_Check;
assign MUX_Initial_Addr_Select= Exec1 & LNK_Check;

//Going into to the PC_N_To_Find and N_To_Find area
assign PC_N_To_Find_Cnt_En= Exec2 & (PC_N_To_Find_Out==0) & LNK_Check;
assign PC_N_To_Find_Sload= Cond_Met;
assign N_To_Find_Reg_Sload= Exec2 & (PC_N_To_Find_Out==0) & LNK_Check;
endmodule



