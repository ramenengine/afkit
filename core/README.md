# Core Modules

## Creating the display

A display window is automatically created when the kit loads. There is no need for you to write code to create a window.

The parameters of the window are defined in kitconfig.f. Here they are:

\| initial-scale \| \( -- x y \) \|Integer scaling, default is \(1,1\) \| initial-res \| \( -- w h \) \| In pixels

### Utility display words

```text
: resolution ( w h -- )
```

Resize the display. If the desired size is unchanged nothing happens.

\| displayw \| \( -- w \) \| displayh \| \( -- h \) \| displaywh \| \( -- w h \) Words for getting the display's dimensions.

## Input

The core has some basic joystick input words.

A keyboard input wordset is provided in the optional library [kb.f](../lib/kb.md).

\| joy \| \( joy\# stick\# - vector \) \| get stick position \| \#joys \| \( -- n \) \| number of connected joysticks \| joystick\[\] \| \( n -- adr \) \| get ALLEGRO\_JOYSTICK\_STATE struct

### Internal input words

Generally you should not need to use the following words since the Piston calls them, but here is a brief explanation of a few of them.

\| polljoys \| \( -- \) \| poll the joystick \| pollkb \| \( -- \) \| poll the keyboard \| kbstate \| \( -- adr \) \| current state read via `pollkb` \| kblast \| \( -- adr \) \| a snapshot from the previous call to `pollkb`.

## Graphics

Some useful graphics words are provided.

### Bitmaps

These words are convenience words to go along with Allegro's bitmap functions.

\|bmpw\|\( bmp -- n \)\|get Allegro bitmap width\| \|bmph\|\( bmp -- n \)\|get Allegro bitmap height\| \|bmpwh\|\( bmp -- w h \)\|get Allegro bitmap dimensions \|hold&gt;\| \( -- \ \)\| Enable bitmap holding for rest of colon definition \|loadbmp\| \( adr c -- bmp \)\| Load a bitmap from a file \|savebmp\| \( bmp adr c -- \) Save a bitmap to a file

### Blending

```text
: blend>  ( op src dest aop asrc adest -- )
```

Enable blending for the rest of a colon definition.

Here are some premade constants you can pass to `blend>`:

\|write-rgba\|Copy pixel values, no alpha transparency\| \|add-rgba\|Additive blending, good for glowy stuff\| \|blend-rgba\|Default alpha-transparency mode\|

### Pen

The pen represents an x,y position on the display. It's a useful way to simplify drawing stuff.

\| at \| \( x y -- \) \| +at \| \( x y -- \) \| at@ \| \( -- x y \)

## The Piston

This is the included standard game loop. See [Piston](piston.md).

