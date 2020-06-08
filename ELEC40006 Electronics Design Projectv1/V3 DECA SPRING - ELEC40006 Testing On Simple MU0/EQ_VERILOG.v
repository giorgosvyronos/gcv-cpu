module EQ
(

input [15:0] accout,
output EQ
);

assign EQ = ~(accout[15] | accout[14] | accout[13] | accout[12] | accout[11] | accout[10] | accout[9] | accout[8] | accout[7] | accout[6] | accout[5] | accout[4] | accout[3] | accout[2] | accout[1] | accout[0]); 

endmodule