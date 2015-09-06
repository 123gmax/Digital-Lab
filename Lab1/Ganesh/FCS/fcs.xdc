# ----------------------------------------------------------------------------
# User LEDs - Bank 33
# ---------------------------------------------------------------------------- 
set_property LOC T22 [get_ports {grant}];  # "LD0"
set_property LOC T21 [get_ports {denied}];  # "LD1"
set_property LOC U22 [get_ports {clk_out}];  # "LD2"
set_property IOSTANDARD LVCMOS33 [get_ports {grant}]; #3.3V
set_property IOSTANDARD LVCMOS33 [get_ports {denied}]; #3.3V
set_property IOSTANDARD LVCMOS33 [get_ports {clk_out}]; #3.3V

# ----------------------------------------------------------------------------
# User DIP Switches - Bank 35
# ---------------------------------------------------------------------------- 
set_property LOC F22 [get_ports {flight_no[0]}];  # "flight_no0"
set_property LOC G22 [get_ports {flight_no[1]}];  # "flight_no1"
set_property LOC H22 [get_ports {flight_no[2]}];  # "flight_no2"
set_property IOSTANDARD LVCMOS18 [get_ports {flight_no[0]}]; #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {flight_no[1]}]; #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {flight_no[2]}]; #1.8V

# ----------------------------------------------------------------------------
# CLOCk Source - Bank 13
# ---------------------------------------------------------------------------- 
set_property LOC Y9 [get_ports {clk}];  # "GCLK"
set_property IOSTANDARD LVCMOS33 [get_ports {clk}];

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ---------------------------------------------------------------------------- 
set_property LOC N15 [get_ports {request}];  # "BTNL"
set_property LOC P16 [get_ports {reset}];  # "BTNC"
set_property IOSTANDARD LVCMOS18 [get_ports {reset}];     #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {request}];     #1.8V
