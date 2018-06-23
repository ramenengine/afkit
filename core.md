# Core Modules

## Creating the display

A display window is automatically created when the kit loads.

The parameters of it are defined in kitconfig.f.

| initial-scale | ( -- x y )  |Integer scaling, default is (1,1)
| initial-res  | ( -- w h )  | In pixels

### Utility display words

```
: resolution ( w h -- )
```
Resize the display. If the desired size is unchanged nothing happens.

```
: displayw  display al_get_display_width ;
: displayh  display al_get_display_height ;
: displaywh  displayw displayh ;
```
Words for getting the display's dimensions.

## Input (basic)

| joy | ( joy# stick# - vector ) | get stick position
| #joys | ( -- n ) | number of connected joysticks
| joystick[] | ( n -- adr )  | get ALLEGRO_JOYSTICK_STATE struct

### Internal input words

Generally you should not need to use the following words since the Piston calls them, but here is a brief explanation of a few of them.

| polljoys | ( -- ) | poll the keyboard
| pollkb | ( -- ) | poll the keyboard
| kbstate | ( -- adr ) | current state read via `pollkb`
| kblast | ( -- adr ) | a snapshot from the previous call to `pollkb`.


## Graphics (basic)

Some useful graphics words are provided.

### Bitmaps

These words are convenience words to go along with Allegro's bitmap functions.

|bmpw|( bmp -- n )|get Allegro bitmap width|
|bmph|( bmp -- n )|get Allegro bitmap height|
|bmpwh|( bmp -- w h )|get Allegro bitmap dimensions
|hold>| ( -- \<code\> )| Enable bitmap holding for rest of colon definition
|loadbmp| ( adr c -- bmp )| Load a bitmap from a file
|savebmp| ( bmp adr c -- ) Save a bitmap to a file

### Blending

```
: blend>  ( op src dest aop asrc adest -- )
```

Enable blending for the rest of a colon definition.

Here are some premade constants you can pass to `blend>`:

|write-rgba|Copy pixel values, no alpha transparency|
|add-rgba|Additive blending, good for glowy stuff|
|blend-rgba|Default alpha-transparency mode|

### Pen

The pen represents an x,y position on the display.   It's a useful way to simplify drawing stuff.

```
: at   ( x y -- )
: +at  ( x y -- )
: at@  ( -- x y )
```


## The Piston
This is the included standard game loop.  See [Piston](piston.md).