module door (clock, state, indicators);

input clock;
input reg [5:0] state;      //Entradas. Los últimos dos bits son los cinturones, los otros son las puertas.
output reg [4:0] indicators; //Salidas. El último bit corresponde al buzzer.

/*      Condiciones de Estado       */
always @(*) begin
    if (state[0])
        indicators[0] <= 1'b1;
    else
        indicators[0] <= 1'b0;
    
    if (state[1])
        indicators[1] <= 1'b1;
    else
        indicators[1] <= 1'b0;
    
    if (state[2])
        indicators[2] <= 1'b1;
    else
        indicators[2] <= 1'b0;
    
    if (state[3])
        indicators[3] <= 1'b1;
    else
        indicators[3] <= 1'b0;
end


/*      Clock 1Hz       */
reg [27:0] counter;
parameter DIVISOR = 27'd25000000;
reg clk_1hz;

always @(posedge clock) begin
    counter <= counter + 1'b1;
    if (counter == DIVISOR - 1'b1)  begin
        counter <= 0;
        clk_1hz <= ~clk_1hz;
    end
end

/*      Buzzer       */
reg [5:0] buzzer_counter;
assign flag = indicators[0] | indicators[1] | indicators[2] | indicators[3];

always @(posedge clk_1hz) begin
    if (flag)
        indicators[4] <= ~indicators[4];
    else
        indicators[4] <= 0;
end

endmodule
