module top(row, col, clk, headlights, dir);

input clk;
input [3:0] row;
output wire [5:0] dir;
output wire [3:0] col;
output reg headlights;

wire [3:0] data;
wire [3:0] d_data;

reg on;
reg [1:0] t_signal;
reg brake;
reg hazard;
reg [1:0] trans;

keypad kp(.clk(clk), .row(row), .col(col), .out(data));
debounce db0(.clk(clk), .pb(data[0]), .pb_out(d_data[0]));
debounce db1(.clk(clk), .pb(data[1]), .pb_out(d_data[1]));
debounce db2(.clk(clk), .pb(data[2]), .pb_out(d_data[2]));
debounce db3(.clk(clk), .pb(data[3]), .pb_out(d_data[3]));

ts ts1(clk, t_signal, hazard, dir);

initial begin
    t_signal <= 0;
    brake <= 0;
    hazard <= 0;
    trans <= 0;  
end

always @(d_data, on) begin
    
    if ((d_data == 4'd5) & (on == 0)) begin   //Encendido
        on <= 1'b1;
     end else if ((d_data == 4'd5) & (on==1'b1)) begin
        on <= 1'b0;
    end
end

always @(*) begin

    if (on==1'b1) begin
    
        if (d_data == 4'd8) begin     //Luces
            headlights <= ~headlights;
        end

        if ((d_data == 4'd4) & (t_signal[1] == 1'b0)) begin    //Dir. Izquierda
            t_signal <= 2'b00;
            t_signal <= 2'b10;
        end else if ((d_data == 4'd4) & (t_signal[1] == 1'b1)) begin
            t_signal <= 2'b00;
        end
        if ((d_data == 4'd6) & (t_signal[0] == 1'b0)) begin   //Dir. Derecha
            t_signal <= 2'b00;
            t_signal <= 2'b01;
        end else if ((d_data == 4'd6) & (t_signal[0] == 1'b1)) begin
            t_signal <= 2'b00;
        end

        if (d_data == 4'd15) begin   //Freno
            brake = ~brake;
        end
        
        if (d_data == 4'd7) begin
            hazard = ~hazard;
        end
        
        if (d_data == 4'd1) //Park
            trans <= 2'b00;
        if (d_data == 4'd2) //Reverse
            trans <= 2'b01;
        if (d_data == 4'd3) //Neutral
            trans <= 2'b10;
        if (d_data == 4'd10) //Drive
            trans <= 2'b11;
    end
end

endmodule