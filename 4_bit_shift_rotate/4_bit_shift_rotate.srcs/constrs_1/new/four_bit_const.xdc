# Clock signal
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33}           [get_ports {clk100MHz}];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk100MHz}];
# Buttons
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {rst}]; # Center Button
# Switches
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {NumIn[0]}];  # Switch 0
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {NumIn[1]}];  # Switch 1
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {NumIn[2]}];  # Switch 2
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {NumIn[3]}];  # Switch 3
##set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {A[5]}];  # Switch 5
#set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {A[6]}];  # Switch 6
#set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {A[7]}];  # Switch 7
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {Ctrl[0]}];  # Switch 13 (control)
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {Ctrl[1]}];  # Switch 14 (control)
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {Ctrl[2]}];  # Switch 15 (control)

# LEDs
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {NumOut_led[0]}];  # LED 0
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {NumOut_led[1]}];  # LED 1
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {NumOut_led[2]}];  # LED 2
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {NumOut_led[3]}];  # LED 3
#set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {A_led[4]}];  # LED 4
#set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {A_led[5]}];  # LED 5
#set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {A_led[6]}];  # LED 6
#set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {A_led[7]}];  # LED 7
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {Ctrl_led[0]}];  # LED 13
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {Ctrl_led[1]}];  # LED 14
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {Ctrl_led[2]}];  # LED 15

#7 Segment Display
set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[0]}]; # CA
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[1]}]; # CB
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[2]}]; # CC
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[3]}]; # CD
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[4]}]; # CE
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[5]}]; # CF
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[6]}]; # CG
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {LEDOUT[7]}]; # DP

set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[0]}]; # AN0
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[1]}]; # AN1
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[2]}]; # AN2
set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {LEDSEL[3]}]; # AN3
