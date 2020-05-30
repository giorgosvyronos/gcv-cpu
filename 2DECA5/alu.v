module alu ( instruction, rddata, rsdata, carrystatus, skipstatus, exec1,
    aluout, carryout, skipout, carryen, skipen, wenout) ;

// v1.01

input [15:0] instruction; // from IR'
input exec1;          // timing signal: when things happen
input [15:0] rddata;  // Rd register data outputs
input [15:0] rsdata;  // Rs register data outputs
input carrystatus;    // the Q output from CARRY
input skipstatus;     // the Q output from SKIP

output [15:0] aluout; // the ALU block output, written into Rd
output carryout;       // the CARRY out, D for CARRY flip flop
output skipout;        // the SKIP output, D for SKIP flip flop
output carryen;        // the enable signal for CARRY flip-flop
output skipen;         // the enable signal for SKIP flip-flop
output wenout;         // the enable for writing Rd in the register file

// these wires are for convenience to make logic easier to see
wire [2:0] opinstr = instruction [6:4];    // OP field from IR'
wire cwinstr = instruction [7];            // 1 => write CARRY: CW from IR'
wire [3:0] condinstr = instruction [11:8]; // COND field from IR'
wire [1:0] cininstr = instruction [13:12];  // CIN field from IR'
wire [1:0] code = instruction [15:14];     // bits from IR': must be 11 for ARM instruction
//=============================FIELDS===========================//
wire add, sub, mov, xsr;	//ALU OPERATION
wire czero, cone, cc, cmsb;	//CIN
wire al, nv, cs, CC;	//COND
wire S; //Write Carry
//===========================WRITE CARRY========================//
assign S = (instruction[7]);
//==============================ALU=============================//
assign add = (~instruction[6] & ~instruction[5] & ~instruction[4]);
assign sub = (~instruction[6] & ~instruction[5] & instruction[4]);
assign mov = (~instruction[6] & instruction[5] & ~instruction[4]);
assign xsr = (~instruction[6] & instruction[5] & instruction[4]);
//==============================CIN=============================//
assign czero = (~instruction[13] & ~instruction[12]);
assign cone = (~instruction[13] & instruction[12]);
assign cc = (instruction[13] & ~instruction[12]);
assign cmsb = (instruction[13] & instruction[12]);
//==============================COND============================//
assign al = (~instruction[11] & ~instruction[10] & ~instruction[9] & ~instruction[8]);
assign nv = (~instruction[11] & ~instruction[10] & ~instruction[9] & instruction[8]);
assign cs = (~instruction[11] & ~instruction[10] & instruction[9] & ~instruction[8]);
assign CC = (~instruction[11] & ~instruction[10] & instruction[9] & instruction[8]);

///============================END FIELDS=======================//
//==========================NEW INSTRUCTION=====================//
wire bitand; //Bitwise AND *100*
wire bitor;	//Bitwise OR *101*

assign bitand = (instruction[6] & ~instruction[5] & ~instruction[4]);
assign bitor = (instruction[6] & ~instruction[5] & instruction[4]);

//==============================================================//
reg [16:0] alusum; // the 17 bit sum, 1 extra bit so ALU carry out can be extracted
wire cin; // The ALU carry input, determined from instruction as in ISA spec
wire shiftin; // value shifted into bit 15 on LSR, determined as in ISA spec

// do not change
assign alucout = alusum [16]; // carry bit from sum, or shift if OP = 011
assign aluout = alusum [15:0]; // 16 normal bits from sum

// change as needed
assign wenout = exec1 & (instruction[15] & instruction[14]);  // correct timing, UPDATED

assign carryen = exec1 & S; // correct timing, UPDATED

assign carryout = (alucout & (add|sub|mov|bitand|bitor))|(xsr & rsdata[0]); // UPDATED
                           
									
assign cin = (czero & 0)|(cone & 1)|(cc & carrystatus)|(cmsb &rsdata[15]);	//UPDATED

assign shiftin = (S & cin);     // ***************UPDATED

assign skipout = code[1]&code[0]&((al & 0)|(nv & 1)|(cs & carryout)|(CC & ~carryout));	//UPDATED**************
assign skipen = exec1 & (add|sub|mov|xsr|bitand|bitor) ;	//UPDATED**************

always @(*) // do not change this line - it makes sure we have combinational logic
  begin
    case (opinstr)
      // alusum is 17 bit so we must extend the two operands to 17 bits using 0
      // otherwise Verilog default extension will sign-extend these inputs
      // that create a subtle (not always obvious) error in carry out
      // note that ~ is bit inversion operator.
      3'b000  : alusum = {1'b0,rddata} + {1'b0,rsdata} + cin;   // if OP = 000
      3'b001  : alusum = {1'b0,rddata} + {1'b0,~rsdata} + cin;  // if OP = 001
      3'b010  : alusum = {1'b0,rsdata} + cin;                // if OP = 010
      3'b011  : alusum = {rsdata[0], shiftin, rsdata[15:1]}; // if OP = 011
		//////////////////////////////////////////////////////////////////////////
      3'b100  : alusum = {1'b0,rddata} & {1'b0,rsdata};			 // if OP = 100
		3'b101  : alusum = {1'b0,rddata} | {1'b0,rsdata};			 // if OP = 101
		// to do (optional): add additional instructions as cases here
      // available cases: 3'b100,3'b101,3'b110, 3'b111
      default : alusum = 0;// default output for unimplemented OP values, do not change
    endcase;
  end

endmodule