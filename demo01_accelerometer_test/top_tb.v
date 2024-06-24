`timescale 1ns/1ps
module top_tb();

reg CLK;
reg NRESET;
wire [7:0]LED;
/*
top #(.div_coef(32'd100)) 
DUT (
	.CLK12M(CLK),
	.USER_BTN(NRESET),
	.LED(LED)
);
*/

wire spi_clk;
wire spi_sdo;
wire spi_cs;
wire [31:0] data_out;
wire ready;

reg spi_sdi;
reg [31:0] data_in;
reg [5:0] n_bits;
reg request;

spi_master #(.div_coef(32'd100))
DUT2 (
	.clk_in(CLK),
	.nrst(NRESET),
	.spi_sck(spi_clk),
	.spi_mosi(spi_sdo),
	.spi_miso(spi_sdi),
	.spi_csn(spi_cs),
	.mosi_data(data_in),
	.miso_data(data_out),
	.nbits(n_bits),
	.request(request),
	.ready(ready)
);

initial begin
	NRESET <= 1'b0;
	CLK <= 1'b0;
	spi_sdi <= 1'b0;
	data_in <= 32'b1000111100000000;
	n_bits <= 6'd16;
	request <= 1'b0;
	
	#400 NRESET <= 1'b1;
	#400 request <= 1'b1;
	#200 request <= 1'b0;
end

initial begin
	#50000 spi_sdi <= 1'b1;
end

always begin
	#100 CLK <= !CLK;
end

endmodule