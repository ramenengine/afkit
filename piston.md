# Piston

The piston is a general-purpose main loop with many features.  Its primary purpose is to drive games but it could be used for other kinds of applications.

## Phases

### Pump

Processes Allegro events.

`etype` fetches the current event type.

`evt` fetches the current event.

See piston.f for an example of how to use these words.

`pump>` programs the pump phase.  The grammar is the same as `does>`.

### Step

Processes some code continuously.  As of now it's locked to 60fps with no frame-skipping (there once was frame-skipping, but it was removed for simplicity.)

`step>` programs the pump phase.  The grammar is the same as `does>`.

### Show

Same as Step but renders the result.  Actually this phase happens before Step.

### Error catching

If an error is caught in any of the phases the values `pumperr` `steperr` and `showerr` will be set to the error code.

## Mount

`mount` implements integer scaling, as well as letterboxing in fullscreen mode.

Its counterpart `unmount` resets the current transformation matrix and clipping box.

Both words reset the blending mode.

## Other features

These tasks are performed by the piston for you.

- Poll the keyboard and joysticks
- Fullscreen toggling with ALT-ENTER (manipulates `fs`, which can be changed directly)
- Hides mouse if `oscursor` is 0.
- If the window loses focus, processing is suspended.
- Processing the window close event
- If `<alt>` or `<ctrl>` are being held when the window loses/regains focus they are automatically released.
- Frame counter `frmctr`

## Keyboard controls

ALT+ENTER toggles fullscreen

CTRL+F4 quits to desktop

F12 breaks the loop

TILDE toggles a variable called `info`

## Misc. words

`ctrl?`

`alt?`

`me` - a `value` used by Ramen.

`frmctr` - a `value` that returns the number of times the Step phase has run.