module DECODE
(

input fetch,
input exec1,
input exec2,
//op=opcode(First_Four_Bits_Of_Insuction)
input [3:0] op,
input EQ,
input MI,

output Extra,
output shiftreg_en,
output shiftreg_load,
output alu_add_sub,
output pc_sload,
output pc_cnt_en,
output mux1_sel,
output mux2_sel,
output mux3_sel,
output IR_en,
output RAM_wren
);

wire LDA,STA,ADD,SUB,JMP,JMI,JEQ,STP,LDI,LSL,LSR;
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

assign Extra = LDA|ADD|SUB;  
assign pc_sload = exec1 & (JMP | JMI&MI | JEQ&EQ );
assign pc_cnt_en = exec1 & (LDA | STA | SUB | JMI&~MI | JEQ&~EQ | LDI | LSR | LSL ); 
assign mux1_sel = exec1 & (JMP | JMI&MI | JEQ&EQ | STP) | fetch;
assign mux2_sel = exec1;
assign mux3_sel = exec2&ADD | exec2&SUB;
assign IR_en = exec1;
assign RAM_wren = exec1&STA;
assign shiftreg_en = exec1&(LDI | LSR | LSL) | exec2&(LDA | ADD | SUB);
assign shiftreg_load = exec1&LDI | exec2&(LDA | ADD | SUB);
assign alu_add_sub = exec2&ADD; 
endmodule
