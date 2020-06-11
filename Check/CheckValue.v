module CheckValue
(
	input[15:0] ValuetoFind, // The value we wish to check if exists in Linked List
	input[15:0] CurrentNode, //Value of current node A
	input[15:0] NextAddressNode, //Address of Next Node
	output CheckValue, //Check Whether Value exists at Node 
	output[15:0] AddressStore //Location Storing Follow-up Node
);

//Address Location of Next Node passed to RAM Address Read
assign AddressStore[15:0] = NextAddressNode[15:0];

//Value of current Node Checked
assign CheckValue = ~(
	(CurrentNode[15] & ~ValuetoFind[15] | ~CurrentNode[15] & ValuetoFind[15])|
	(CurrentNode[14] & ~ValuetoFind[14] | ~CurrentNode[14] & ValuetoFind[14])|
	(CurrentNode[13] & ~ValuetoFind[13] | ~CurrentNode[13] & ValuetoFind[13])|
	(CurrentNode[12] & ~ValuetoFind[12] | ~CurrentNode[12] & ValuetoFind[12])|
	(CurrentNode[11] & ~ValuetoFind[11] | ~CurrentNode[11] & ValuetoFind[11])|
	(CurrentNode[10] & ~ValuetoFind[10] | ~CurrentNode[10] & ValuetoFind[10])|
	(CurrentNode[9] & ~ValuetoFind[9] | ~CurrentNode[9] & ValuetoFind[9])|
	(CurrentNode[8] & ~ValuetoFind[8] | ~CurrentNode[8] & ValuetoFind[8])|
	(CurrentNode[7] & ~ValuetoFind[7] | ~CurrentNode[7] & ValuetoFind[7])|
	(CurrentNode[6] & ~ValuetoFind[6] | ~CurrentNode[6] & ValuetoFind[6])|
	(CurrentNode[5] & ~ValuetoFind[5] | ~CurrentNode[5] & ValuetoFind[5])|
	(CurrentNode[4] & ~ValuetoFind[4] | ~CurrentNode[4] & ValuetoFind[4])|
	(CurrentNode[3] & ~ValuetoFind[3] | ~CurrentNode[3] & ValuetoFind[3])|
	(CurrentNode[2] & ~ValuetoFind[2] | ~CurrentNode[2] & ValuetoFind[2])|
	(CurrentNode[1] & ~ValuetoFind[1] | ~CurrentNode[1] & ValuetoFind[1])|
	(CurrentNode[0] & ~ValuetoFind[0] | ~CurrentNode[0] & ValuetoFind[0])
);

endmodule