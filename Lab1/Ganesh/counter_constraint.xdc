# ----------------------------------------------------------------------------
# User LEDs - Bank 33
# ---------------------------------------------------------------------------- 
set_property LOC T22 [get_ports {COUNT[0]}];  # "LD0"
set_property LOC T21 [get_ports {COUNT[1]}];  # "LD1"
set_property LOC U22 [get_ports {COUNT[2]}];  # "LD2"
set_property LOC U21 [get_ports {COUNT[3]}];  # "LD3"
set_property IOSTANDARD LVCMOS33 [get_ports {COUNT[0]}]; #3.3V
set_property IOSTANDARD LVCMOS33 [get_ports {COUNT[1]}]; #3.3V
set_property IOSTANDARD LVCMOS33 [get_ports {COUNT[2]}]; #3.3V
set_property IOSTANDARD LVCMOS33 [get_ports {COUNT[3]}]; #3.3V
# ----------------------------------------------------------------------------
# User DIP Switches - Bank 35
# ---------------------------------------------------------------------------- 
set_property LOC F22 [get_ports {VALUE[0]}];  # "SW0 Val0"
set_property LOC G22 [get_ports {VALUE[1]}];  # "SW1 Val1"
set_property LOC H22 [get_ports {VALUE[2]}];  # "SW2 Val2"
set_property LOC F21 [get_ports {VALUE[3]}];  # "SW3 Val3"
set_property LOC H19 [get_ports {UP}];  # "SW4 UP/DOWN_bar"
set_property LOC H18 [get_ports {AUTO}];  # "SW5 AUTO/Manual_bar"
set_property IOSTANDARD LVCMOS18 [get_ports {VALUE[0]}]; #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {VALUE[1]}]; #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {VALUE[2]}]; #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {VALUE[3]}]; #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {UP}];       #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {AUTO}];     #1.8V

# ----------------------------------------------------------------------------
# CLOCk Source - Bank 13
# ---------------------------------------------------------------------------- 
set_property LOC Y9 [get_ports {clk}];  # "GCLK"
set_property IOSTANDARD LVCMOS33 [get_ports {clk}];

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ---------------------------------------------------------------------------- 
set_property LOC N15 [get_ports {LOAD}];  # "BTNL"
set_property LOC P16 [get_ports {RESET}];  # "BTNC"
set_property PACKAGE_PIN R18 [get_ports {TICK}];  # "BTNR"
set_property IOSTANDARD LVCMOS18 [get_ports {LOAD}];     #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {RESET}];     #1.8V
set_property IOSTANDARD LVCMOS18 [get_ports {TICK}];     #1.8V
