# Input

## Input

A standard keyboard input lexicon is provided in [kb.f](../lib/kb.md).

The core also has some basic joystick input words.

`#joys`\( -- n \) Number of connected joysticks   
`joystick[]` \( n -- adr \) Get ALLEGRO\_JOYSTICK\_STATE struct  
`stick` \( joy\# stick\# -- f: x y \) Get joystick coordinates \(floats -1e...1e\)  
`btn` \( joy\# button\# -- n\# \) Get button state \(integer 0...32767\)

### Other input words

`polljoys` \( -- \) poll the joystick   
`pollkb` \( -- \) poll the keyboard   
`kbstate` \( -- adr \) current state read via `pollkb`   
`kblast` \( -- adr \) a copy of `kbstate` from the previous call to `pollkb`.

