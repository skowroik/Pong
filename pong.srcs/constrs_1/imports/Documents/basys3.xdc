## FPGA VGA Graphics Part 1: Basys 3 Board Constraints
## Learn more at https://timetoexplore.net/blog/arty-fpga-vga-verilog-01

## Clock
set_property -dict {PACKAGE_PIN W5  IOSTANDARD LVCMOS33} [get_ports {CLK}];
create_clock -add -name sys_clk_pin -period 10.00 \
    -waveform {0 5} [get_ports {CLK}];

## Use BTNC as Reset Button (active high)
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {RST_BTN}];

## VGA Connector
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports {VGA_R[0]}];
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVCMOS33} [get_ports {VGA_R[1]}];
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports {VGA_R[2]}];
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS33} [get_ports {VGA_R[3]}];
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports {VGA_B[0]}];
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {VGA_B[1]}];
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {VGA_B[2]}];
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {VGA_B[3]}];
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {VGA_G[0]}];
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {VGA_G[1]}];
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {VGA_G[2]}];
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports {VGA_G[3]}];
set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS33} [get_ports {VGA_HS_O}];
set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS33} [get_ports {VGA_VS_O}];

##Buttons
set_property PACKAGE_PIN T18 [get_ports {button[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {button[2]}]
set_property PACKAGE_PIN W19 [get_ports {button[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {button[3]}]
set_property PACKAGE_PIN T17 [get_ports {button[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {button[1]}]
set_property PACKAGE_PIN U17 [get_ports {button[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {button[4]}]

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design] 

##Seven segment segment display
set_property PACKAGE_PIN W7 [get_ports {sseg_DG[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_DG[0]}]
set_property PACKAGE_PIN W6 [get_ports {sseg_DG[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_DG[1]}]
set_property PACKAGE_PIN U8 [get_ports {sseg_DG[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_DG[2]}]
set_property PACKAGE_PIN V8 [get_ports {sseg_DG[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_DG[3]}]
set_property PACKAGE_PIN U5 [get_ports {sseg_DG[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_DG[4]}]
set_property PACKAGE_PIN V5 [get_ports {sseg_DG[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_DG[5]}]
set_property PACKAGE_PIN U7 [get_ports {sseg_DG[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_DG[6]}]

## Seven segment display decimal point
set_property PACKAGE_PIN V7 [get_ports sseg_DP]
set_property IOSTANDARD LVCMOS33 [get_ports sseg_DP]

## Seven segment display anode
set_property PACKAGE_PIN U2 [get_ports {sseg_AN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_AN[0]}]
set_property PACKAGE_PIN U4 [get_ports {sseg_AN[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_AN[1]}]
set_property PACKAGE_PIN V4 [get_ports {sseg_AN[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_AN[2]}]
set_property PACKAGE_PIN W4 [get_ports {sseg_AN[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sseg_AN[3]}]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property PACKAGE_PIN V13 [get_ports {led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property PACKAGE_PIN V3 [get_ports {led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property PACKAGE_PIN W3 [get_ports {led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property PACKAGE_PIN U3 [get_ports {led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
set_property PACKAGE_PIN P3 [get_ports {led[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
set_property PACKAGE_PIN N3 [get_ports {led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property PACKAGE_PIN P1 [get_ports {led[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
set_property PACKAGE_PIN L1 [get_ports {led[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]
