\ Allegro stuff
[undefined] allegro-display-flags [if]
ALLEGRO_WINDOWED  ALLEGRO_RESIZABLE or  ALLEGRO_OPENGL_3_0 or  ALLEGRO_PROGRAMMABLE_PIPELINE or
  constant allegro-display-flags
[then]

[undefined] alert [if] : alert cr type ; [then]

: init-allegro-all
  al_init
    not if  s" Couldn't initialize Allegro." alert     -1 abort then
  al_init_image_addon
    not if  s" Allegro: Couldn't initialize image addon." alert      -1 abort then
  al_init_primitives_addon
    not if  s" Allegro: Couldn't initialize primitives addon." alert -1 abort then
  al_init_font_addon
    not if  s" Allegro: Couldn't initialize font addon." alert       -1 abort then
  al_init_ttf_addon
    not if  s" Allegro: Couldn't initialize TTF addon." alert       -1 abort then
  al_install_mouse
    not if  s" Allegro: Couldn't initialize mouse." alert            -1 abort then
  al_install_keyboard
    not if  s" Allegro: Couldn't initialize keyboard." alert         -1 abort then
  al_install_joystick
    not if  s" Allegro: Couldn't initialize joystick." alert         -1 abort then
;

0 constant FLIP_NONE
1 constant FLIP_H
2 constant FLIP_V
3 constant FLIP_HV
