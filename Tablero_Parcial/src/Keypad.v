module keypad(clk, row, col, out);

input clk;
input [3:0] row;
output reg [3:0] col;
output reg [3:0] out;

/*      Clock 500Hz       */
reg [19:0] counter;
parameter DIVISOR = 19'd500000;
reg clk_500hz;

always @(posedge clk) begin
    counter <= counter + 1'b1;
    if (counter == DIVISOR - 1'b1)  begin
        counter <= 0;
        clk_500hz <= ~clk_500hz;
    end
end

assign flag = ~(col[0] | col[1] | col[2] | col[3]);

always @(posedge clk_500hz) begin

    if ((col[3] == 1) || (flag == 1)) begin
        col <= 4'b0001;
    end else begin
        col <= (col << 1);
    end

end

/*      Interacción Keypad       */


always @(posedge clk_500hz) begin

case ({col, row})
    //First Column
    8'b0001_0001: out <= 4'd1;  //Park
    8'b0001_0010: out <= 4'd4;  //Izquierda
    8'b0001_0100: out <= 4'd7;  //Intermitentes
    8'b0001_1000: out <= 4'd14; //Mirror #1
    //Second Column
    8'b0010_0001: out <= 4'd2;  //Reverse
    8'b0010_0010: out <= 4'd5;  //On
    8'b0010_0100: out <= 4'd8;  //Headlights
    8'b0010_1000: out <= 4'd0;  
    //Third Column
    8'b0100_0001: out <= 4'd3;  //Neutral
    8'b0100_0010: out <= 4'd6;  //Derecha
    8'b0100_0100: out <= 4'd9;
    8'b0100_1000: out <= 4'd15; //Freno
    //Fourth Column
    8'b1000_0001: out <= 4'd10; //Direct
    8'b1000_0010: out <= 4'd11;
    8'b1000_0100: out <= 4'd12;
    8'b1000_1000: out <= 4'd13; //Mirror #2

    default: out <= 4'bZZZZ;
endcase 
    
end


endmodule