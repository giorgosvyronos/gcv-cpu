module LNK_RND_FBCV_SUPPORTED_BASE_DECODE
(

input Fetch,
input Exec1,
input Exec2,
//op=opcode(First_Four_Bits_Of_Insuction)
input [3:0] op,
input EQ,
input MI,

output Extra,
output Shiftreg_En,
output Shiftreg_Load,
output Alu_Add_Sub,
output PC_Sload,
output PC_Cnt_En,
output MUX1_Sel,
output MUX2_Sel,
output MUX3_Sel,
output IR_En,
output RAM_Wren,
output FBC_Check,
output RND_Check,
output LNK_Check
);

wire LDA,STA,ADD,SUB,JMP,JMI,JEQ,STP,LDI,LSL,LSR,FBC,RND,LNK;
assign LDA = ~op[3] & ~op[2] & ~op[1] & ~op[0]; //0000
assign STA = ~op[3] & ~op[2] & ~op[1] &  op[0]; //0001
assign ADD = ~op[3] & ~op[2] &  op[1] & ~op[0]; //0010
assign SUB = ~op[3] & ~op[2] &  op[1] &  op[0]; //0011
assign JMP = ~op[3] &  op[2] & ~op[1] & ~op[0]; //0100
assign JMI = ~op[3] &  op[2] & ~op[1] &  op[0]; //0101
assign JEQ = ~op[3] &  op[2] &  op[1] & ~op[0]; //0110
assign STP = ~op[3] &  op[2] &  op[1] &  op[0]; //0111
assign LDI =  op[3] & ~op[2] & ~op[1] & ~op[0]; //1000
assign LSL =  op[3] & ~op[2] & ~op[1] &  op[0]; //1001
assign LSR =  op[3] & ~op[2] &  op[1] & ~op[0]; //1010
assign FBC =  op[3] &  op[2] & ~op[1] & ~op[0]; //1100
assign RND =  op[3] &  op[2] & ~op[1] &  op[0]; //1101
assign LNK =  op[3] &  op[2] &  op[1] & ~op[0]; //1110

assign Extra = LDA|ADD|SUB;  

assign PC_Sload = Exec1 & (JMP | JMI&MI | JEQ&EQ );
assign PC_Cnt_En = Exec1 & (ADD | LDA | STA | SUB | JMI&~MI | JEQ&~EQ | LDI | LSR | LSL | FBC | RND | LNK); 

assign MUX1_Sel = Exec1 & (JMP | JMI | JEQ | STP | LDI | LSL | LSR) | Fetch; //Actually since this is not a pipeplined version Fetch and only would be enough but by doing that we can Fetch the same instruction again from Exec1->Fetch - in Fetch State nothing occurs so it won't make any difference but it will be nicer than the content of a random cell. 
assign MUX2_Sel = Exec1;
assign MUX3_Sel = (Exec2 & ADD) | (Exec2 & SUB);
assign IR_En = Exec1;
assign RAM_Wren = Exec1 & STA;

assign Shiftreg_En = Exec1&(LDI | LSR | LSL) | Exec2&(LDA | ADD | SUB);
assign Shiftreg_Load = Exec1&LDI | Exec2&(LDA | ADD | SUB);
assign Alu_Add_Sub = Exec2&ADD; 

assign FBC_Check=FBC;
assign RND_Check=RND;
assign LNK_Check=LNK;

endmodule
