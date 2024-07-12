module gw_gao(
    \d_data[3] ,
    \d_data[2] ,
    \d_data[1] ,
    \d_data[0] ,
    \data[3] ,
    \data[2] ,
    \data[1] ,
    \data[0] ,
    on,
    \t_signal[1] ,
    \t_signal[0] ,
    headlights,
    brake,
    hazard,
    \trans[1] ,
    \trans[0] ,
    \ts1/sequence[5] ,
    \ts1/sequence[4] ,
    \ts1/sequence[3] ,
    \ts1/sequence[2] ,
    \ts1/sequence[1] ,
    \ts1/sequence[0] ,
    clk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \d_data[3] ;
input \d_data[2] ;
input \d_data[1] ;
input \d_data[0] ;
input \data[3] ;
input \data[2] ;
input \data[1] ;
input \data[0] ;
input on;
input \t_signal[1] ;
input \t_signal[0] ;
input headlights;
input brake;
input hazard;
input \trans[1] ;
input \trans[0] ;
input \ts1/sequence[5] ;
input \ts1/sequence[4] ;
input \ts1/sequence[3] ;
input \ts1/sequence[2] ;
input \ts1/sequence[1] ;
input \ts1/sequence[0] ;
input clk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \d_data[3] ;
wire \d_data[2] ;
wire \d_data[1] ;
wire \d_data[0] ;
wire \data[3] ;
wire \data[2] ;
wire \data[1] ;
wire \data[0] ;
wire on;
wire \t_signal[1] ;
wire \t_signal[0] ;
wire headlights;
wire brake;
wire hazard;
wire \trans[1] ;
wire \trans[0] ;
wire \ts1/sequence[5] ;
wire \ts1/sequence[4] ;
wire \ts1/sequence[3] ;
wire \ts1/sequence[2] ;
wire \ts1/sequence[1] ;
wire \ts1/sequence[0] ;
wire clk;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top u_ao_top(
    .control(control0[9:0]),
    .data_i({\d_data[3] ,\d_data[2] ,\d_data[1] ,\d_data[0] ,\data[3] ,\data[2] ,\data[1] ,\data[0] ,on,\t_signal[1] ,\t_signal[0] ,headlights,brake,hazard,\trans[1] ,\trans[0] ,\ts1/sequence[5] ,\ts1/sequence[4] ,\ts1/sequence[3] ,\ts1/sequence[2] ,\ts1/sequence[1] ,\ts1/sequence[0] }),
    .clk_i(clk)
);

endmodule
