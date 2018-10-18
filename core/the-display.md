# The Display

The primary function of AFKit is to provide a graphical display for making games.  

The display created by AFKit has any size you specify in kitconfig.f \(default 640x480\) and is configured with a 24-bit depth buffer.  

A display window is automatically created for you when the kit loads.

You can get the ALLEGRO\_DISPLAY handle with the word `display`.

The parameters of the window are defined in kitconfig.f. Here they are:

`initial-scale` \( -- x y \) Integer scaling, default is \(1,1\)   
`initial-res` \( -- w h \) In pixels

### Utility display words

```text
: resolution ( w h -- )
```

Resizes the display. If the desired size is the same as the current one nothing happens.

`displayw` \( -- w \)   
`displayh` \( -- h \)   
`displaywh` \( -- w h \) Words for getting the display's dimensions.

