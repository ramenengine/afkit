\ display
\   need only one for now
\   simplified to sidestep degenerative stalling bug
\   derived from Bubble

0 value default-font
0 value fps
0 value allegro?
0 value eventq
0 value display

[defined] ALLEGRO_AUDIO
    [if]  include kit/audio-allegro  [else]  include kit/audio-fmod  [then]

\ --------------------------- initializing allegro ----------------------------

: assertAllegro
  allegro? ?exit
  true to allegro?
  al_init
    not if  " INIT-ALLEGRO: Couldn't initialize Allegro." alert     -1 abort then
  al_init_image_addon
    not if  " Allegro: Couldn't initialize image addon." alert      -1 abort then
  al_init_primitives_addon
    not if  " Allegro: Couldn't initialize primitives addon." alert -1 abort then
  al_init_font_addon
    not if  " Allegro: Couldn't initialize font addon." alert       -1 abort then
  al_init_ttf_addon
    not if  " Allegro: Couldn't initialize TTF addon." alert       -1 abort then
  al_install_mouse
    not if  " Allegro: Couldn't initialize mouse." alert            -1 abort then
  al_install_keyboard
    not if  " Allegro: Couldn't initialize keyboard." alert         -1 abort then
  al_install_joystick
    not if  " Allegro: Couldn't initialize joystick." alert         -1 abort then
\    usere al_init_user_event_source
  init-audio
;

assertAllegro

\ Native and Display Resolutions
create native  /ALLEGRO_DISPLAY_MODE /allot
  al_get_num_display_modes 1 -  native  al_get_display_mode
: xy@   dup @ swap cell+ @ ;
: displayw  display al_get_display_width ;
: displayh  display al_get_display_height ;
: displaywh  displayw displayh ;

\ ----------------------- initializing the display ----------------------------

: initDisplay  ( w h -- )
  assertAllegro
  al_create_event_queue  to eventq
  ALLEGRO_VSYNC 1 ALLEGRO_SUGGEST  al_set_new_display_option
  0 40 al_set_new_window_position

  ALLEGRO_WINDOWED  ALLEGRO_RESIZABLE or  ALLEGRO_OPENGL_3_0 or  ALLEGRO_PROGRAMMABLE_PIPELINE or
    al_set_new_display_flags

  al_create_display  to display
  display 0 0 al_set_window_position
  al_create_builtin_font to default-font
  eventq  display       al_get_display_event_source  al_register_event_source

  display al_get_display_refresh_rate ?dup 0= if 60 then to fps
  eventq                al_get_mouse_event_source    al_register_event_source
  eventq                al_get_keyboard_event_source al_register_event_source
;

: valid?  ['] @ catch nip 0 = ;
[undefined] initial-res [if]  : initial-res  640 480 ;  [then]

: +display  display valid? ?exit  initial-res initDisplay ;
: -display  display valid? -exit
    display al_destroy_display  0 to display
    eventq al_destroy_event_queue  0 to eventq ;
: -allegro  -display  false to allegro?  al_uninstall_system ;

\ ------------------------ words for switching windows ------------------------
[defined] linux [if]
    : focus  drop ;
    : >display ;  : >ide ;
[else]
    : focus  ( winapi-window - )  \ force window via handle to be the active window
      dup 1 ShowWindow drop  dup BringWindowToTop drop  SetForegroundWindow drop ;
    : >display  ( -- )  display al_get_win_window_handle focus ;  \ force allegro display window to take focus
    defer >ide
    :noname [ is >ide ]  ( -- )  HWND focus ;                                                     \ force the Forth prompt to take focus
    >ide
[then]

