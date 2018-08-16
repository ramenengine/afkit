\ Universal main loop, simple version; no fixed point
\  It just processes events and spits out frames, no timer, no frameskipping.
\  The previous version tried to have frameskipping and framepacing, but it became choppy after
\    an hour or two running and I couldn't figure out the cause.
\  The loop has some common controls:
\    F12 - break the loop
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
0 value 'pump
0 value 'step
0 value 'show
0 value me    \ for Ramen
0 value (me)  \ save/restore

\ Flags
variable info  \ enables debugging mode display
variable fs    \ is fullscreen enabled?
variable interact   \ if on, cmdline will receive keys.  check if false before doing game input, if needed.
variable logevents  \ enables spitting out of event codes

\ Defers
defer ?overlay  ' noop is ?overlay  \ render ide  ( -- )
defer ?system   ' noop is ?system   \ system events ( -- )
defer onDisplayClose  :is onDisplayClose  bye ;  ( -- )

\ Event stuff
create evt  256 /allot
: etype  evt ALLEGRO_EVENT.TYPE @ ;
z" AKFS" @ constant FULLSCREEN_EVENT


: poll  pollKB  pollJoys  [defined] dev [if] pause [then] ;
: break  true to breaking? ;

transformation m1
variable clipx
variable clipy
variable clipw
variable cliph

: clip ( x y w h -- ) 
    #globalscale * s>f cliph sf!
    #globalscale * s>f clipw sf!
    s>f  clipy sf!
    s>f  clipx sf!
    m1   clipx clipy   al_transform_coordinates
    clipx sf@ f>s
    clipy sf@ f>s
    clipw sf@ f>s
    cliph sf@ f>s al_set_clipping_rectangle
;

: mount  ( -- )
    0 0 at
    
    m1 al_identity_transform
    m1 #globalscale s>f 1sf dup al_scale_transform
    fs @ if
        m1
            native x@ 2 / desired-res x@ #globalscale * 2 / -  s>f 1sf 
            native y@ 2 / desired-res y@ #globalscale * 2 / -  s>f 1sf  al_translate_transform
    then
    m1 al_use_transform

    0 0 desired-res xy@ clip
    
    ALLEGRO_ADD ALLEGRO_ALPHA ALLEGRO_INVERSE_ALPHA
    ALLEGRO_ADD ALLEGRO_ONE   ALLEGRO_ONE
        al_set_separate_blender
    
    display al_set_target_backbuffer ;

variable (catch)
: try  dup -exit  sp@ cell+ >r  code> catch (catch) !  r> sp!  (catch) @ ;

\ : alt?  evt ALLEGRO_KEYBOARD_EVENT.modifiers @ ALLEGRO_KEYMOD_ALT and ;
: standard-events
  etype ALLEGRO_EVENT_DISPLAY_RESIZE = if  display al_acknowledge_resize   123 . then
  etype ALLEGRO_EVENT_DISPLAY_CLOSE = if  onDisplayClose  then
  etype ALLEGRO_EVENT_KEY_DOWN = if
    evt ALLEGRO_KEYBOARD_EVENT.keycode @ case
      <alt>    of  true to alt?  endof
      <altgr>  of  true to alt?  endof
      <lctrl>  of  true to ctrl?  endof
      <rctrl>  of  true to ctrl?  endof
      <enter>  of  alt? -exit  fs @ not fs ! endof
      <f4>     of  alt? -exit  bye  endof
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


variable winx  variable winy
: ?poswin   \ save/restore window position when toggling in and out of fullscreen
    display al_get_display_flags ALLEGRO_FULLSCREEN_WINDOW and if
        fs @ 0= if  r> call  display winx @ winy @ al_set_window_position  then
    else
        fs @ if     display winx winy al_get_window_position  then
    then ;

: al-emit-user-event  ( type -- )  \ EVT is expected to be filled, except for the type
    evt ALLEGRO_EVENT.type !  uesrc evt 0 al_emit_user_event ;

0 value #lastscale
variable newfs
: 2s>f  swap s>f s>f ;
: ?fs
    ?poswin  display ALLEGRO_FULLSCREEN_WINDOW fs @ $1 and al_toggle_display_flag drop
    fs @ newfs @ = ?exit
    fs @ newfs !
    fs @ if
        #globalscale to #lastscale
        native xy@ 2s>f f/ 
        desired-res xy@ 2s>f f/ f> if
            native y@ desired-res y@ /
        else
            native x@ desired-res x@ /
        then
            to #globalscale
    else
        #lastscale to #globalscale
    then
    FULLSCREEN_EVENT al-emit-user-event
;

: ?renderr  dup to renderr  if  cr ." Render Error "  renderr .  then ;
: show  mount  'show try ?renderr  mount  ?overlay  al_flip_display ;
: step  'step try to steperr  1 +to #frames ;
: /go  resetkb  false to breaking?   >display  false to alt?  false to ctrl?  me to (me) ;
: go/  eventq al_flush_event_queue  >ide  false to breaking?  (me) to me ;
: show>  r>  to 'show ;  ( -- <code> )  ( -- )
: step>  r>  to 'step ;  ( -- <code> )  ( -- )
: pump>  r> to 'pump   0 to 'step ;  ( -- <code> )  ( -- )
: @event  ( -- flag )  eventq evt al_get_next_event  logevents @ if  etype h.  then ;
: attend
    begin  @event  breaking? not and while
        'pump try to goerr  standard-events  ?system
    repeat ;
: go  /go   begin  show  attend  poll  step  ?fs  breaking?  until  go/ ;

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
