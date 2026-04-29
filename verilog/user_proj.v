`default_nettype none

module tt_um_approx_alu (
    input  wire [7:0] ui_in,
    output reg  [7:0] uo_out,
    inout  wire [7:0] uio,
    input  wire       clk,
    input  wire       rst_n
);

    wire [3:0] op_b      = uio[3:0];
    wire [2:0] opcode    = uio[6:4];
    wire       approx_en = uio[7];

    wire [7:0] add_ex = ui_in + {4'b0, op_b};
    wire [7:0] sub_ex = ui_in - {4'b0, op_b};
    wire [11:0] mul_full = ui_in * {4'b0, op_b};
    
    wire [7:0] add_approx = {ui_in[7:4] + op_b, 4'h0};
    wire [7:0] mul_approx = mul_full[11:4];
    
    wire [7:0] and_res = ui_in & {4'b0, op_b};
    wire [7:0] or_res  = ui_in | {4'b0, op_b};
    wire [7:0] xor_res = ui_in ^ {4'b0, op_b};

    wire err_add = (add_ex != add_approx);
    wire err_mul = (mul_full[3:0] != 4'b0);
    wire err_flag = (opcode == 3'd1) ? err_add :
                    (opcode == 3'd3) ? err_mul : 1'b0;

    wire [7:0] result = (opcode == 3'd0) ? add_ex      :
                        (opcode == 3'd1) ? add_approx  :
                        (opcode == 3'd2) ? sub_ex      :
                        (opcode == 3'd3) ? mul_approx  :
                        (opcode == 3'd4) ? and_res     :
                        (opcode == 3'd5) ? or_res      :
                        (opcode == 3'd6) ? xor_res     :
                                           ui_in;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) uo_out <= 8'h00;
        else        uo_out <= { (approx_en && err_flag), result[6:0] };
    end

    assign uio = 8'hzz;
endmodule
`default_nettype wire
