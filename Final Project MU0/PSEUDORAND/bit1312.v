module bit1312
(
	input [15:0] valueX, //the value of X
	output [15:0] buff //output of buffer
);
assign buff[0] = 0;
assign buff[1] = 0;
assign buff[2] = 0;
assign buff[3] = 0;
assign buff[4] = 0;
assign buff[5] = 0;
assign buff[6] = 0;
assign buff[7] = 0;
assign buff[8] = 0;
assign buff[9] = 0;
assign buff[10] = 0;
assign buff[11] = 0;
assign buff[12] = valueX[0];
assign buff[13] = valueX[1];
assign buff[14] = valueX[2];
assign buff[15] = valueX[3];

endmodule
