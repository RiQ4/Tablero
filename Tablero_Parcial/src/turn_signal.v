module ts(clk, turn, hazard, sequence);
input clk;
input [1:0] turn;
input hazard;
output reg [5:0] sequence;


/*      Clock 5Hz       */
reg [23:0] counter;
parameter DIVISOR = 23'd100000;
reg clk_5hz;

always @(posedge clk) begin
    counter <= counter + 1'b1;
    if (counter == DIVISOR - 1'b1)  begin
        counter <= 0;
        clk_5hz <= ~clk_5hz;
    end
end

always @(posedge clk_5hz) begin
    
    if (hazard == 1'b1) begin
        if ((turn == 2'b01) & (sequence[2:0] == 0)) begin
            sequence [2:0] <= 3'b001;
        end else if ((turn == 2'b01) & (sequence[2:0] > 0) & (sequence[2:0] != 3'b100)) begin
            sequence [2:0] <= (sequence [2:0] << 1);
        end else if ((turn == 2'b01) & (sequence[2:0] == 3'b100)) begin
            sequence [2:0] <= 3'b000;
        end

        if ((turn == 2'b10) & (sequence[5:3] == 0)) begin
            sequence [5:3] <= 3'b100;
        end else if ((turn == 2'b10) & (sequence[5:3] > 0) & (sequence[5:3] != 3'b001)) begin
            sequence [5:3] <= (sequence [5:3] >> 1);
        end else if ((turn == 2'b10) & (sequence[5:3] == 3'b001)) begin
            sequence [5:3] <= 3'b000;
        end
    end

end

endmodule
    
    
        