module StateMachine
(
	input [2:0] Q, //current state
	input E,//Extra
	output [2:0] NS //next state
	
);

assign NS[0] = (~Q[2] & ~Q[1] & ~Q[0]) ;

assign NS[1] = (~Q[2] & ~Q[1] & Q[0] & E);

assign NS[2] = 0; 

endmodule