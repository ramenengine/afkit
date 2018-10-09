# Basic Usage

To load the library say `<M> <m> <r> include afkit/afkit.f` where M m r are the version numbers. If you don't want to have to bother with versioning you can supply 0 0 0. `afkit/main.f` does this for you and is useful for AFKit development \(don't use it for apps\).

To make an app, you need to program the piston. Something like this:

```text
0 0 0 include afkit/afkit.f
fvariable r
fvariable g
fvariable b
: mypump  pump>  etype ALLEGRO_EVENT_KEY_DOWN = if cr ." Key was pressed!" then ;
: mystep  step>  0.001e r f+!  -0.0009e g f+!  0.0006e b f+! ;
: myshow  show>  r f@ g f@ b f@ 1e 4sf al_clear_to_Color ;
mypump mystep myshow
go
```

In this small example `mystep` tells the piston to cycle the r,g,b variables and `myshow` tells it to clear the screen using those values.

The line `mypump mystep myshow` executes the words that program the piston and `go` kicks it off.

