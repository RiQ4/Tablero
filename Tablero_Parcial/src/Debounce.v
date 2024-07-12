module debounce(input pb, clk, output pb_out);

wire Q1,Q2,Q2_bar,Q0;

/*      Clock 500Hz       */
reg [17:0] counter;
parameter DIVISOR = 17'd100000;
reg clk_500hz;

always @(posedge clk) begin
    counter <= counter + 1'b1;
    if (counter == DIVISOR - 1'b1)  begin
        counter <= 0;
        clk_500hz <= ~clk_500hz;
    end
end


my_dff d0(clk_500hz, pb,Q0);
my_dff d1(clk_500hz, Q0,Q1 );
my_dff d2(clk_500hz, Q1,Q2 );

assign Q2_bar = ~Q2;
assign pb_out = Q1 & Q2_bar;

endmodule


