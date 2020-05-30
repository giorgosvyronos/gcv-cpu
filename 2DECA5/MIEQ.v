module MIEQ
(
	input [15:0] acc,	//accumulator state
	
	output MI,
	output EQ
);

assign MI = acc[15];
assign EQ = ~(acc[15] | acc[14] | acc[13] | acc[12] | acc[11] | acc[10] | acc[9] | acc[8] | acc[7] | acc[6] | acc[5] | acc[4] | acc[3] | acc[2] | acc[1] | acc[0]);

endmodule