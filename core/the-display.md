# The Display

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

