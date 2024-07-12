module servo (
    input clk,
    input [1:0] angle_select, 
    output reg pwm_out
);
    reg [19:0] counter; 
    reg [19:0] pulse_width; 

    always @(posedge clk) begin
            counter <= counter + 20'd1;
            if (counter < pulse_width)
                pwm_out <= 1'b1;
            else
                pwm_out <= 1'b0;

            if (counter >= 20'd500000) 
                counter <= 20'd0;
        
    end

    always @(*) begin
        case (angle_select)
            2'b00: pulse_width = 20'd20000; 
            2'b01: pulse_width = 20'd46666; 
            2'b10: pulse_width = 20'd93333; 
            2'b11: pulse_width = 20'd120000; 
            default: pulse_width = 20'd20000;
        endcase
    end
endmodule