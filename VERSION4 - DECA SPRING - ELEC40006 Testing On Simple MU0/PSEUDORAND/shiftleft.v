module shiftleft
(
	input [15:0] valueX, //the value of X
	output [15:0] shiftedX //output of shift
);
assign shiftedX[0] = 0;
assign shiftedX[1] = valueX[0];
assign shiftedX[2] = valueX[1];
assign shiftedX[3] = valueX[2];
assign shiftedX[4] = valueX[3];
assign shiftedX[5] = valueX[4];
assign shiftedX[6] = valueX[5];
assign shiftedX[7] = valueX[6];
assign shiftedX[8] = valueX[7];
assign shiftedX[9] = valueX[8];
assign shiftedX[10] = valueX[9];
assign shiftedX[11] = valueX[10];
assign shiftedX[12] = valueX[11];
assign shiftedX[13] = valueX[12];
assign shiftedX[14] = valueX[13];
assign shiftedX[15] = valueX[14];

endmodule
