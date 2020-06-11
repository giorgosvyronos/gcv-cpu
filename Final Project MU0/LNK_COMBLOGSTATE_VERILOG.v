module LNK_COMBLOGSTATE_VERILOG
(
input [2:0] in,
input extra,
input L, //LINKED_LIST 
input R, //RND_STATE
input FBCV_State,
output [2:0] out
);
assign out[0]= ~in[0] & ~in[1] & ~in[2];

assign out[1]= (~extra & FBCV_State & ~in[2] & ~in[1] & in[0] & ~R & ~L) | (extra & ~in[2] & ~in[1] & in[0]) 
| (FBCV_State & ~in[2] & in[1] & ~in[0] & ~R & ~L) | (R & ~extra & ~FBCV_State & ~in[2] & ~in[1] & in[0] & ~L) 
| (R & ~FBCV_State & ~in[2] & in[1] & ~in[0] & ~L) | (L & ~R & ~extra & ~FBCV_State & ~in[2] & ~in[1] & in[0])
| (L & ~R & ~FBCV_State & ~in[2] & in[1] & ~in[0]);

assign out[2]=0;

endmodule

