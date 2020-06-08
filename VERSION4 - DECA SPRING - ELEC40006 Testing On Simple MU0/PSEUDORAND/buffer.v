module buffer
(
	input [15:0] valueX, //the value of X
	input mux, //the value of the mux 0 OR 1
	output [15:0] buff //output of buffer
);
assign buff[0] = mux & valueX[0];
assign buff[1] = mux & valueX[1];
assign buff[2] = mux & valueX[2];
assign buff[3] = mux & valueX[3];
assign buff[4] = mux & valueX[4];
assign buff[5] = mux & valueX[5];
assign buff[6] = mux & valueX[6];
assign buff[7] = mux & valueX[7];
assign buff[8] = mux & valueX[8];
assign buff[9] = mux & valueX[9];
assign buff[10] = mux & valueX[10];
assign buff[11] = mux & valueX[11];
assign buff[12] = mux & valueX[12];
assign buff[13] = mux & valueX[13];
assign buff[14] = mux & valueX[14];
assign buff[15] = mux & valueX[15];

endmodule
