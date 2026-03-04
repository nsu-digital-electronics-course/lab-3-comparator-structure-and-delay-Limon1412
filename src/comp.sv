`timescale 1ns / 1ps

module comp(
    input [31:0] a,
    input [31:0] b,
    output logic gt,
    output logic eq,
    output logic lt
    );
    
// TODO
// Âîò òóò îïèñûâàåì ñâîé êîìïàðàòîð  
    logic [31:0] xnor_ab;  
    logic [31:0] pref_eq;   
    logic [31:0] gt_bit;    
    logic [31:0] lt_bit;    

    assign xnor_ab = ~(a ^ b);

    assign pref_eq[31] = 1'b1;

    genvar i;
    generate
        for (i = 30; i >= 0; i = i - 1) begin : gen_pref
            assign pref_eq[i] = pref_eq[i+1] & xnor_ab[i+1];
        end
    endgenerate

    assign gt_bit = pref_eq & a & ~b;
    assign lt_bit = pref_eq & ~a & b;

    assign gt = |gt_bit;
    assign lt = |lt_bit;
    assign eq = &xnor_ab;

endmodule
