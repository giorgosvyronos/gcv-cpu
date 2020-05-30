module LDI
(
	input [15:0] Q, //NEXT state
	input exec1,
	output [15:0] d //decoded state
	
);
wire ifldi;

assign ifldi = Q[15] & ~Q[14] & ~Q[13] & ~Q[12];

assign d[11:0] = Q[11:0];

assign d[15] = Q[15] & (~ifldi | ~exec1);

assign d[14] = Q[14] & (~ifldi | ~exec1);

assign d[13] = Q[13] & (~ifldi | ~exec1);

assign d[12] = Q[12] & (~ifldi | ~exec1);

endmodule