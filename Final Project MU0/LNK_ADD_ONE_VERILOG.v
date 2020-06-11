module LNK_ADD_ONE
(
input [11:0] Initial_Addr_MUX_In,
output [11:0] Added_One,
output [11:0] Not_Added
);

assign Added_One= Initial_Addr_MUX_In +1;
assign Not_Added= Initial_Addr_MUX_In;

endmodule
