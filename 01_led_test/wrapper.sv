// =============================================================================
// Test 01: LEDs, buttons, switches, clock
// Board:   Terasic DE2-115 (Cyclone IV E, EP4CE115F29C7)
//
// What you should see after programming:
//   LEDG[8]    blinks on its own (about 0.7 s on, 0.7 s off)  -> clock works
//   LEDG[3:0]  light while KEY[3:0] is held down               -> buttons work
//   LEDR[17:0] follow the slide switches SW[17:0]              -> switches work
//
// Port names MUST match the names in pins/DE2-115_pin_assignments.csv,
// because Quartus places pins by matching names.
// =============================================================================
`timescale 1ns / 1ps

module wrapper (
    input  logic        CLOCK_50,   // 50 MHz oscillator, PIN_Y2
    input  logic [3:0]  KEY,        // push buttons, active-low (0 = pressed)
    input  logic [17:0] SW,         // slide switches, 1 = up
    output logic [17:0] LEDR,       // red LEDs, 1 = on
    output logic [8:0]  LEDG        // green LEDs, 1 = on
);

logic clk_12m288;
wire pll_locked;

clock pll_inst(
    .areset(1'b0),
    .inclk0(CLOCK_50),
    .c0(clk_12m288),
    .locked(pll_locked)
);

    // -------------------------------------------------------------------------
    // Clock check: a free-running counter.
    // Bit 25 toggles every 2^25 / 50,000,000 s = 0.67 s, slow enough to see.
    // The "= '0" starting value works on FPGAs (not on real chips).
    // -------------------------------------------------------------------------
    logic [23:0] count = '0;

    always_ff @(posedge clk_12m288) begin
        if(!pll_locked) begin
            count <= count + 1'b1;
        end

    end
    
    assign LEDG[8] = count[23];

    // -------------------------------------------------------------------------
    // Button check: KEY is active-low, so invert it.
    // No synchronizer is needed here because no flip-flop samples KEY;
    // it drives the LED directly. The synthesizer will need one.
    // -------------------------------------------------------------------------
    assign LEDG[3:0] = ~KEY;
    assign LEDG[7:4] = '0;

    // -------------------------------------------------------------------------
    // Switch check: switches are active-high, so pass them straight through.
    // -------------------------------------------------------------------------
    assign LEDR = SW;

endmodule
