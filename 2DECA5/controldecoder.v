module  controldecoder
(
	input [2:0] Q,	//Q[2]=FETCH,Q[1]=EXEC2,Q[0]=EXEC1
	input [3:0] C,	//opcode for instructions
	input MI,		//MI input
	input EQ,		//EQ input
	input skipff,
	
	output E,
	output mux1sel,
	output mux2sel,
	output IRsload,
	output PCsload,
	output PCcnt_en,
	output wren
);

//====================Instructions====================//
wire lda,sta,add,sub,jmp,jmi,jeq,stp,ldi,lsl,lsr;

assign lda = ~C[3] & ~C[2] & ~C[1] & ~C[0];
assign sta = ~C[3] & ~C[2] & ~C[1] & C[0];
assign add = ~C[3] & ~C[2] & C[1] & ~C[0];
assign sub = ~C[3] & ~C[2] & C[1] & C[0];
assign jmp = ~C[3] & C[2] & ~C[1] & ~C[0];
assign jmi = ~C[3] & C[2] & ~C[1] & C[0];
assign jeq = ~C[3] & C[2] & C[1] & ~C[0];
assign stp = ~C[3] & C[2] & C[1] & C[0];
assign ldi = C[3] & ~C[2] & ~C[1] & ~C[0];
assign lsl = C[3] & ~C[2] & ~C[1] & C[0];
//assign lsr = C[3] & ~C[2] & C[1] & ~C[0];
assign arm = C[3] & C[2];

//=====================OpCode========================//
wire fetch,exec1,exec2;

assign fetch = Q[2] & ~Q[1] & ~Q[0];
assign exec2 = ~Q[2] & Q[1] & ~Q[0];
assign exec1 = ~Q[2] & ~Q[1] & Q[0];
///////////////////////////////////////////////////////
assign E = lda | add | sub | arm;

assign mux1sel = (lda & exec1)|(add & exec1)|(sub & exec1);

assign mux2sel = exec1;

assign IRsload = exec1;

assign PCsload = ((jmp & exec1)|(jmi & exec1 & MI)|(jeq & exec1 & EQ)) & (~skipff);
/////This maybe should be exec2 for 3 cycle instructions??/////
assign PCcnt_en = (lda & exec1)|(sta & exec1)|(add & exec1)|(sub & exec1)|(jmi & exec1 & !MI)|(jeq & exec1 & !EQ)|(ldi & exec1)|(lsl & exec1)|(arm & exec1);

assign wren = (sta & exec1) & (~skipff);

endmodule