# DE2-115 Bring-up

Small tests to learn the Terasic DE2-115 board (Cyclone IV E, `EP4CE115F29C7`)
before integrating into our [team synthesizer repo](https://github.com/bananababoo/Synthesizer).
Each test is its own Quartus project and builds on the previous one.

| # | Test | Proves | Status |
|---|---|---|---|
| 01 | `01_led_test/` LEDs, buttons, switches | Compile/program flow, pins, clock | Not tested yet |
| 02 | Input sync + debounce | Clean one-press-one-event buttons | Planned |
| 03 | 7-segment display | Active-low HEX digits | Planned |
| 04 | I2C codec setup | WM8731 configured (ACK on LEDs) | Planned |
| 05 | Test tone | Square wave out the 3.5 mm jack | Planned |

## Layout

```
pins/DE2-115_pin_assignments.csv   every board pin + voltage standard (from SoCET tutorial)
01_led_test/                        one folder per test: .qpf, .qsf, .sdc, wrapper.sv, README
```

## Conventions

- Top module is always `wrapper`, with ports named exactly as in the pin CSV
  (`CLOCK_50`, `KEY`, `SW`, `LEDR`, `LEDG`, `HEX0`…). This is how Quartus maps
  signals to physical pins.
- Pins for a new test: copy the matching lines from the CSV into the test's
  `.qsf`, or use `Assignments → Import Assignments` with the CSV.
- Only source and settings are committed; build output is in `.gitignore`.
- Each test's README records what was expected and what actually happened.

## Board notes

- `KEY[3:0]` are **active-low** (0 when pressed). `SW` and LEDs are active-high.
- `HEX0`–`HEX7` segments are **active-low** (0 lights a segment).
- LEDs, keys, switches and HEX0–2 use 2.5 V I/O; audio, I2C and HEX3–7 use 3.3 V.
  The pin CSV sets this automatically.
- SW19 must be on **RUN** to program over JTAG.
