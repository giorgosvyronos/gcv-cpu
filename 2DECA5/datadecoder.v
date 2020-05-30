module  datadecoder
(
	input [2:0] Q,	//Q[2]=FETCH,Q[1]=EXEC2,Q[1]=EXEC0
	input [3:0] C,	//opcode for instructions
	
	output accen,
	//output accsload,
	//output accshiftin,
	output MUX3sel,
	output addsub
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
//=====================OpCode========================//
wire fetch,exec1,exec2;

assign fetch = Q[2] & ~Q[1] & ~Q[0];
assign exec2 = ~Q[2] & Q[1] & ~Q[0];
assign exec1 = ~Q[2] & ~Q[1] & Q[0];
///////////////////////////////////////////////////////

assign accen = (lda & exec2)|(add & exec2)|(sub & exec2)|(ldi & exec1)|(lsl & exec1);

//assign accsload = (lda & exec2)|(add & exec2)|(sub & exec2)|(ldi & exec1)|(lsl & exec1);

//assign accshiftin = 0;

assign MUX3sel = (add & exec2)|(sub & exec2);

assign addsub = (add & exec2);

endmodule