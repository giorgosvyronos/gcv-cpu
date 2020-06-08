module FORCE
(
input exec1,
input [15:0] dataout,


output [15:0] ldiout,
output [15:0] nonldiout,
output mux_force
);

wire LDI,LSR,LSL;
assign LDI = dataout[15] & ~dataout[14] & ~dataout[13] & ~dataout[12];
assign mux_force = exec1 & LDI;
assign nonldiout = dataout;
assign ldiout[11:0] = dataout[11:0];
assign ldiout[15:12] = 0;

endmodule
