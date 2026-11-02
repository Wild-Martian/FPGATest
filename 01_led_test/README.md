# Test 01: LEDs, buttons, switches, clock

**Goal:** prove the whole flow works (code → compile → pins → program → board).

## Expected result

| Check | What to do | Expected |
|---|---|---|
| Clock | Nothing | `LEDG8` blinks about every 0.7 s |
| Buttons | Hold `KEY0`–`KEY3` | `LEDG0`–`LEDG3` light while held |
| Switches | Flip `SW0`–`SW17` up | The red LED above each switch lights |

## Run it (Quartus GUI, on the lab PC the board is plugged into)

1. `File → Open Project` → `led_test.qpf`.
   Pins, device and clock are already set in `led_test.qsf` and `led_test.sdc`.
2. `Processing → Start Compilation`. Should end "successful" and create
   `output_files/led_test.sof`.
3. Board: USB cable in the **USB Blaster** port, power on, **SW19 = RUN**.
4. `Tools → Programmer` → Hardware Setup = **USB-Blaster**, Mode = **JTAG** →
   Add File `output_files/led_test.sof` → check Program/Configure → **Start**.

## Run it (command line)

```bash
quartus_sh --flow compile led_test
jtagconfig                                   # board should be listed
quartus_pgm -m jtag -o "p;output_files/led_test.sof"
```

Compiling works over SSH; programming must run on the PC the board is plugged into.

## If it doesn't work

- **"No Hardware" / programming fails:** check cable and power, then
  `killall jtagd; jtagd -d`, or power-cycle the board and restart Quartus.
- **Compiles but nothing happens:** check the Fitter's pin report; port names
  in `wrapper.sv` must match the names in the pin CSV exactly.
- **LED on until you press the button:** `KEY` wasn't inverted (it's active-low).
- The board's factory demo (flashing lights) running at power-on is normal;
  programming replaces it. JTAG programming is lost when power is turned off.

## Result

- Date tested:
- Lab PC:
- Clock / buttons / switches:  ☐ / ☐ / ☐
- Notes:
