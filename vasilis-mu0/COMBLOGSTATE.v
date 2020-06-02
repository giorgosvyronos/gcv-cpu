module COMBLOGSTATE
(
input [2:0] in,
input extra,
output [2:0] out
);
assign out[0]= ~in[0] & ~in[1] & ~in[2];
assign out[1]= extra & ~in[2] & ~in[1] & in[0];
assign out[2]=0;
endmodule

