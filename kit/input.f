\ keyboard and joystick support, integer/float version

\ -------------------------------- keyboard -----------------------------------
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
\ ------------------------------ end keyboard ---------------------------------


\ -------------------------------- joysticks ----------------------------------
\ NTS: we don't handle connecting/disconnecting devices yet,
\   though Allegro 5 /does/ support it. (via an event)

_AL_MAX_JOYSTICK_STICKS constant MAX_STICKS
create joysticks   MAX_STICKS /ALLEGRO_JOYSTICK_STATE * /allot
: joystick[]  /ALLEGRO_JOYSTICK_STATE *  joysticks + ;
: >joyhandle  al_get_joystick ;
: joy ( joy# stick# - vector )  \ get stick position (fixed point)
  /ALLEGRO_JOYSTICK_STATE_STICK *  swap joystick[]
  ALLEGRO_JOYSTICK_STATE.sticks + ;
: #joys  al_get_num_joysticks ;
: pollJoys ( -- )  #joys for  i >joyhandle i joystick[] al_get_joystick_state  loop ;
\ ------------------------------ end joysticks --------------------------------
