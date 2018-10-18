# Graphics

Some basic graphics words are provided.

### Bitmaps

These words are convenience words to go along with Allegro's bitmap functions.

`bmpw` \( bmp -- n \) get Allegro bitmap width  
`bmph` \( bmp -- n \) get Allegro bitmap height  
`bmpwh`\( bmp -- w h \) get Allegro bitmap dimensions   
`hold>` \( -- &lt;code&gt; \) Enable bitmap holding for rest of colon definition   
`loadbmp` \( adr c -- bmp \) Load a bitmap from a file   
`savebmp` \( bmp adr c -- \) Save a bitmap to a file  
`-bmp` \( bmp -- \) Destroy a bitmap

### Blending

```text
: blend  ( op src dest aop asrc adest -- )
: blend>  ( op src dest aop asrc adest -- <code> )
```

These words enable a given blending mode.  `blend>` restores the previous blending mode after the code body.

Here are some pre-made constants you can pass to `blend>`:

`interp-src` Standard alpha blending.  
`add-src` Additive blending.  
`write-src` Writes red, green, blue, AND alpha. \(I.e. no blending.\)

### Transforms

Standard 4x4 matrix supported by Allegro.

`/transform` \( -- n\# \) Size of transform \(16 cells\)  
`transform` \( -- &lt;name&gt; \) Create a named transform  
`identity` \( transform -- \) Reset a transform

### Pen

The pen represents the current x,y position for drawing.

`at`\( x y -- \)   
`+at` \( x y -- \)   
`at@` \( -- x y \)  
`penx` \( -- adr \)   
`peny` \( -- adr \)

