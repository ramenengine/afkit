# Basic Usage

To load the library the simple way is to say `include afkit/afkit.f`. 

A more advanced way that supports reloading and version-checking looks something like this:

```text
include afkit/ans/version.f
include afkit/ans/depend.f
depend afkit/afkit.f
#1 #4 #3 [afkit] [checkver]
```

_Note: If you are reading these docs in order to use Ramen, you don't need to explicitly load AllegroForthKit._

To make an app, you need to program the piston. Here is an example:

```text
include afkit/afkit.f
fvariable r
fvariable g
fvariable b
: mypump  pump>  etype ALLEGRO_EVENT_KEY_DOWN = if cr ." Key was pressed!" then ;
: mystep  step>  0.001e r f+!  -0.0009e g f+!  0.0006e b f+! ;
: myshow  show>  r f@ g f@ b f@ 1e 4sf al_clear_to_Color ;
mypump mystep myshow
```

In this small example `mystep` tells the piston to cycle the r,g,b variables and `myshow` tells it to clear the screen using those values.

The line `mypump mystep myshow` executes the words that program the piston.

If you `include` this file and type `go` \(if not using Ramen's IDE\) it will kick off the app.  You should see the screen slowly cycle colors and when you press a key the message "Key was pressed!" will be printed to the output terminal.

