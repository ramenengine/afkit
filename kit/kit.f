include kit/ans/version.f
$000909 [version] kit-ver

[defined] page [if] page [then] 

\ Load external libraries
[undefined] EXTERNALS_LOADED [if]  \ ensure that external libs are only ever loaded once.
    s" kitconfig.f" file-exists [if]
        include kitconfig.f
    [else]
        .( Missing kitconfig.f!!!) QUIT
    [then]
    include kit/platforms.f

    true constant EXTERNALS_LOADED

    cd kit/ans/ffl
        ffling +order
            include ffl/dom.fs
            include ffl/b64.fs
        ffling -order
    cd ../../..

    : empty  only forth s" (empty) marker (empty)" evaluate ;
    marker (empty)
[then]


include kit/ans/section

[section] Libraries
\ Load support libraries
include kit/plat/win/fpext      \ depends on FPMATH
include kit/ans/strops         \ ANS
include kit/ans/files          \ ANS
include kit/ans/roger          \ ANS

[section] Audio
[defined] ALLEGRO_AUDIO [if]  include kit/audio-allegro  [then]

\ --------------------------------------------------------------------------------------------------
[section] Variables
0 value default-font
0 value fps
0 value allegro?
0 value eventq
0 value display

\ --------------------------------------------------------------------------------------------------
[section] Display
\ Initializing Allegro and creating the display window
\   need only one for now
\   simplified to sidestep degenerative stalling bug
\   derived from Bubble

include kit/al.f

: assertAllegro
    allegro? ?exit   true to allegro?  init-allegro-all
    \    usere al_init_user_event_source
    initaudio
;

assertAllegro

\ Native and Display Resolutions
create native  /ALLEGRO_DISPLAY_MODE /allot
  al_get_num_display_modes 1 -  native  al_get_display_mode
: xy@   dup @ swap cell+ @ ;
: displayw  display al_get_display_width ;
: displayh  display al_get_display_height ;
: displaywh  displayw displayh ;

\ ------------------------------------ initializing the display ------------------------------------
: initDisplay  ( w h -- )
    assertAllegro
    al_create_event_queue  to eventq
    ALLEGRO_VSYNC 1 ALLEGRO_SUGGEST  al_set_new_display_option
    0 40 al_set_new_window_position
    allegro-display-flags al_set_new_display_flags
    al_create_display  to display    \ Make that display!!!!
    display 0 0 al_set_window_position
    al_create_builtin_font to default-font
    eventq  display       al_get_display_event_source  al_register_event_source
    display al_get_display_refresh_rate ?dup 0= if 60 then to fps
    eventq                al_get_mouse_event_source    al_register_event_source
    eventq                al_get_keyboard_event_source al_register_event_source

    ALLEGRO_DEPTH_TEST 0 al_set_render_state
;

: valid?  ['] @ catch nip 0 = ;
[defined] initial-scale [if] initial-scale [else] 1 [then] value #globalscale
[undefined] initial-res [if]  : initial-res  640 480 ;  [then]

create desired-res  initial-res swap , ,

: +display  display valid? ?exit  desired-res 2@ initDisplay ;
: -display  display valid? -exit
    display al_destroy_display  0 to display
    eventq al_destroy_event_queue  0 to eventq ;
: -allegro  -display  false to allegro?  al_uninstall_system ;
: empty  -display empty ;

: ?same  desired-res 2@ 2over d= -exit  r> drop ;
: resolution  ?same  -display  desired-res 2!  +display ;

\ ----------------------------------- words for switching windows ----------------------------------
[defined] linux [if]
    variable _hwnd
    variable _disp

    0 XOpenDisplay _disp !
    _disp @ _hwnd here XGetInputFocus

    : HWND  _hwnd @ ;

    : focus
        0 XOpenDisplay _disp !
        _disp @ over 0 0 XSetInputFocus
        _disp @ swap XRaiseWindow
        _disp @ 0 XSync ;

    : >display  display al_get_x_window_id focus ;
[else]
    : focus  ( winapi-window - )
      dup 1 ShowWindow drop  dup BringWindowToTop drop  SetForegroundWindow drop ;
    : >display  ( -- )  display al_get_win_window_handle focus ;
[then]

defer >ide
:noname [ is >ide ]  ( -- )  HWND focus ;
>ide

[section] Input
\ keyboard and joystick support, integer/float version
\ ----------------------------------------------- keyboard -----------------------------------------
create kbstate  /ALLEGRO_KEYBOARD_STATE /allot \ current frame's state
create kblast  /ALLEGRO_KEYBOARD_STATE /allot  \ last frame's state
: pollKB
  kbstate kblast /ALLEGRO_KEYBOARD_STATE move
  kbstate al_get_keyboard_state ;
: clearkb  kblast /ALLEGRO_KEYBOARD_STATE erase  kbstate /ALLEGRO_KEYBOARD_STATE erase ;
: resetkb
  clearkb
  al_uninstall_keyboard
  al_install_keyboard  not abort" Error re-establishing the keyboard :/"
  eventq  al_get_keyboard_event_source al_register_event_source ;
\ ----------------------------------------- end keyboard -------------------------------------------
\ ----------------------------------------- joysticks ----------------------------------------------
\ NTS: we don't handle connecting/disconnecting devices yet,
\   though Allegro 5 /does/ support it. (via an event)

_AL_MAX_JOYSTICK_STICKS constant MAX_STICKS
create joysticks   MAX_STICKS /ALLEGRO_JOYSTICK_STATE * /allot
: joystick[]  /ALLEGRO_JOYSTICK_STATE *  joysticks + ;
: >joyhandle  al_get_joystick ;
: joy ( joy# stick# - vector )  \ get stick position
  /ALLEGRO_JOYSTICK_STATE_STICK *  swap joystick[]
  ALLEGRO_JOYSTICK_STATE.sticks + ;
: #joys  al_get_num_joysticks ;
: pollJoys ( -- )  #joys for  i >joyhandle i joystick[] al_get_joystick_state  loop ;
\ ----------------------------------------- end joysticks ------------------------------------------

\ --------------------------------------------------------------------------------------------------
[section] Graphics
\ Graphics essentials; no-fixed-point version
16 cells constant /transform
: transformation  create  here  /transform allot  al_identity_transform ;

\ integer stuff
: bmpw   ( bmp -- n )  al_get_bitmap_width  ;
: bmph   ( bmp -- n )  al_get_bitmap_height  ;
: bmpwh  ( bmp -- w h )  dup bmpw swap bmph ;
: hold>  ( -- <code> )  1 al_hold_bitmap_drawing  r> call  0 al_hold_bitmap_drawing ;
: loadbmp  ( adr c -- bmp ) zstring al_load_bitmap ;
: savebmp  ( bmp adr c -- ) zstring swap al_save_bitmap 0= abort" Allegro: Error saving bitmap." ;
: -bmp  ?dup -exit al_destroy_bitmap ;

create oldblender  6 cells allot
: blend>  ( op src dest aop asrc adest -- )
    oldblender dup cell+ dup cell+ dup cell+ dup cell+ dup cell+ al_get_separate_blender
    al_set_separate_blender  r> call
    oldblender @+ swap @+ swap @+ swap @+ swap @+ swap @ al_set_separate_blender ;
: write-rgba  ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ZERO ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ZERO ;
: add-rgba    ALLEGRO_ADD ALLEGRO_ALPHA ALLEGRO_ONE  ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ONE  ;
: blend-rgba  ALLEGRO_ADD ALLEGRO_ALPHA ALLEGRO_INVERSE_ALPHA  ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ONE ;
blend-rgba al_set_separate_blender

\ Pen
create penx  0 ,  here 0 ,  constant peny
: at   ( x y -- )  penx 2! ;
: +at  ( x y -- )  penx 2+! ;
: at@  ( -- x y )  penx 2@ ;

\ --------------------------------------------------------------------------------------------------
[section] Piston
include kit/piston.f
\ --------------------------------------------------------------------------------------------------
[section] Init
+display
>ide
