`timescale 1ns/1ps
module tb;
    reg  [7:0] ui_in;
    wire [7:0] uo_out;
    reg  [7:0] uio_reg;
    wire [7:0] uio;
    reg  clk, rst_n;

    assign uio = uio_reg;
    tt_um_approx_alu dut(.ui_in(ui_in), .uo_out(uo_out), .uio(uio), .clk(clk), .rst_n(rst_n));

    initial clk = 0;
    always #20 clk = ~clk;

    initial begin
        $dumpfile("sim.vcd"); $dumpvars(0, tb);
        rst_n = 0; ui_in = 0; uio_reg = 0;
        #100 rst_n = 1;

        #40 ui_in = 8'h05; uio_reg = {1'b0, 3'd0, 4'h03};
        #40 if (uo_out[6:0] != 8'h08) $error("ADD Exact FAIL");

        #40 ui_in = 8'h5A; uio_reg = {1'b1, 3'd1, 4'h0F};
        #40 $display("ADD Approx: %h | Flag: %b", uo_out[6:0], uo_out[7]);

        #40 ui_in = 8'h0C; uio_reg = {1'b1, 3'd3, 4'h05};
        #40 $display("MUL Approx: %h | Flag: %b", uo_out[6:0], uo_out[7]);

        #100 $finish;
    end
endmodule
