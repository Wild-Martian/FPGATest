# 50 MHz board clock = 20 ns period
create_clock -name CLOCK_50 -period 20.000 [get_ports CLOCK_50]
derive_clock_uncertainty

# Buttons and switches are asynchronous; LEDs have no timing requirement
set_false_path -from [get_ports {KEY[*] SW[*]}]
set_false_path -to   [get_ports {LEDR[*] LEDG[*]}]
