# ----------------------------------------------------------------------------
# User LEDs - Bank 33
# ---------------------------------------------------------------------------- 
set_property LOC T22 [get_ports {GRANTED}];  # "LD0"
set_property LOC T21 [get_ports {DENIED}];  # "LD1"
set_property IOSTANDARD LVCMOS33 [get_ports {GRANTED}]; #3.3V
set_property IOSTANDARD LVCMOS33 [get_ports {DENIED}]; #3.3V
# ----------------------------------------------------------------------------
# User DIP Switches - Bank 35
# ---------------------------------------------------------------------------- 
set_property LOC F22 [get_ports {PLANE_TYPE[0]}];  # "SW0 Val0"
set_property LOC G22 [get_ports {PLANE_TYPE[1]}];  # "SW1 Val1"
set_property LOC H22 [get_ports {PLANE_TYPE[2]}];  # "SW2 Val2"
set_property IOSTANDARD LVCMOS18 [get_ports {PLANE_TYPE[0]}]; #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {PLANE_TYPE[1]}]; #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {PLANE_TYPE[2]}]; #1.8V
# ----------------------------------------------------------------------------
# CLOCk Source - Bank 13
# ---------------------------------------------------------------------------- 
set_property LOC Y9 [get_ports {CLK}];  # "GCLK"
set_property IOSTANDARD LVCMOS33 [get_ports {CLK}];

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ---------------------------------------------------------------------------- 
set_property LOC N15 [get_ports {REQ}];  # "BTNL"
#set_property LOC P16 [get_ports {RESET}];  # "BTNC"
set_property IOSTANDARD LVCMOS18 [get_ports {REQ}];     #1.8V
#set_property IOSTANDARD LVCMOS18 [get_ports {RESET}];     #1.8V
