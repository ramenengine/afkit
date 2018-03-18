\ Universal main loop, simple version; no fixed point
\  It just processes events and spits out frames, no timer, no frameskipping.
\  The previous version tried to have frameskipping and framepacing, but it became choppy after
\    an hour or two running and I couldn't figure out the cause.
\  The loop has some common controls:
\    CTRL-F12 - break the loop
\    ALT-F4 - quit the process
\    ALT-ENTER - toggle fullscreen
\    TILDE - toggles a flag called INFO

\ Values
0 value #frames \ frame counter.
0 value renderr
0 value steperr
0 value goerr
0 value alt?  \ part of fix for alt-enter bug when game doesn't have focus
0 value ctrl?
0 value breaking?
0 value 'go
0 value 'step
0 value 'show

\ Flags
variable info  \ enables debugging mode display
variable allowwin  allowwin on
variable fs    \ is fullscreen enabled?
variable interact   \ if on, cmdline will receive keys.  check if false before doing game input, if needed.
variable logevents  \ enables spitting out of event codes

\ Other variables
defer ?overlay  ' noop is ?overlay  \ render ide
defer ?system   ' noop is ?system   \ system events
defer onDisplayClose
:is onDisplayClose  0 ExitProcess ;

create evt  256 /allot
: etype  evt ALLEGRO_EVENT.TYPE @ ;

create fse  256 /allot  \ fullscreen event
999 constant EVENT_FULLSCREEN

: poll  pollKB  pollJoys  [defined] dev [if] pause [then] ;
: break  true to breaking? ;
transformation m1
: unmount  ( -- )
    m1 al_identity_transform  m1 global-scale s>f 1sf dup al_scale_transform  m1 al_use_transform
    0 0 displayw displayh al_set_clipping_rectangle
    ALLEGRO_ADD ALLEGRO_ALPHA ALLEGRO_INVERSE_ALPHA  ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ONE al_set_separate_blender
    display al_set_target_backbuffer ;

variable (catch)
: try  dup -exit  sp@ cell+ >r  code> catch (catch) !  r> sp!  (catch) @ ;

\ : alt?  evt ALLEGRO_KEYBOARD_EVENT.modifiers @ ALLEGRO_KEYMOD_ALT and ;
: standard-events
  etype ALLEGRO_EVENT_DISPLAY_RESIZE = if  display al_acknowledge_resize   then
\  etype ALLEGRO_EVENT_DISPLAY_SWITCH_OUT = if  -timer  -audio  then
\  etype ALLEGRO_EVENT_DISPLAY_SWITCH_IN = if  clearkb  +timer   +audio  false to alt?
\    [defined] dev [if] interact on [then] then
  etype ALLEGRO_EVENT_DISPLAY_CLOSE = if  onDisplayClose  then
  etype ALLEGRO_EVENT_KEY_DOWN = if
    evt ALLEGRO_KEYBOARD_EVENT.keycode @ case
      <alt>    of  true to alt?  endof
      <altgr>  of  true to alt?  endof
      <lctrl>  of  true to ctrl?  endof
      <rctrl>  of  true to ctrl?  endof
      <enter>  of  alt? -exit  fs @ not fs ! endof
      <f4>     of  alt? -exit  0 ExitProcess endof
      <f12>    of  break  endof
      <tilde>  of  alt? -exit  info @ not info !  endof
    endcase
  then
  etype ALLEGRO_EVENT_KEY_UP = if
    evt ALLEGRO_KEYBOARD_EVENT.keycode @ case
      <alt>    of  false to alt?  endof
      <altgr>  of  false to alt?  endof
      <lctrl>  of  false to ctrl?  endof
      <rctrl>  of  false to ctrl?  endof
    endcase
  then ;


: fsflag  fs @ allowwin @ not or ;
: ?fserr  0= if fs off  " Fullscreen is not supported by your driver." alert  then ;
variable winx  variable winy
: ?poswin   \ save/restore window position when toggling in and out of fullscreen
    display al_get_display_flags ALLEGRO_FULLSCREEN_WINDOW and if
        fs @ 0= if  r> call  display winx @ winy @ al_set_window_position  then
    else
        fs @ if     display winx winy al_get_window_position  then
    then ;

variable newfs
: ?fs
    ?poswin  display ALLEGRO_FULLSCREEN_WINDOW fsflag al_toggle_display_flag ?fserr
    \ fs @  newfs @  <> if  fse EVENT_FULLSCREEN emit-user-event  then
    fs @ newfs ! ;

: show  unmount  'show try to renderr  unmount  ?overlay  al_flip_display ;
: step  'step try to steperr ;
: /ok  resetkb  false to breaking?   >display  false to alt?  false to ctrl? ;
: ok/  eventq al_flush_event_queue  >ide  false to breaking?  ;
: show>  r>  to 'show ;  ( -- <code> )  ( -- )
: step>  r>  to 'step ;  ( -- <code> )  ( -- )
: go>  r> to 'go   0 to 'step ;  ( -- <code> )  ( -- )
: @event  ( -- flag )  eventq evt al_get_next_event  logevents @ if  etype h.  then ;
: attend
    begin  @event  breaking? not and while
        'go try to goerr  standard-events  ?system
    repeat ;
: ok    /ok   begin  show  1 +to #frames  attend  poll  step  ?fs  breaking?  until  ok/ ;

\ default demo: dark blue screen with bouncing white square
variable x  variable vx  1 vx !
variable y  variable vy  1 vy !
:noname
    show>
    0e 0e 0.5e 1e 4sf al_clear_to_color
    x @ y @ over 50 + over 50 + 4s>f 4sf 1e 1e 1e 1e 4sf al_draw_filled_rectangle
    vx @ x +!  vy @ y +!
    vx @ 0< if  x @ 0 < if  vx @ negate vx !  then then
    vy @ 0< if  y @ 0 < if  vy @ negate vy !  then then
    vx @ 0> if  x @ displayw 50 - >= if  vx @ negate vx !  then then
    vy @ 0> if  y @ displayh 50 - >= if  vy @ negate vy !  then then
    ;  execute
