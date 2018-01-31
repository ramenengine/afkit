\ Graphics essentials; no-fixed-point version
16 cells constant /transform
: transformation  create  here  /transform allot  al_identity_transform ;
transformation m0
: 1-1  m0 al_identity_transform  m0 al_use_transform ;

\ integer stuff
: bmpw   ( bmp -- n )  al_get_bitmap_width  ;
: bmph   ( bmp -- n )  al_get_bitmap_height  ;
: bmpwh  ( bmp -- w h )  dup bmpw swap bmph ;
: hold>  ( -- <code> )  1 al_hold_bitmap_drawing  r> call  0 al_hold_bitmap_drawing ;

: loadbmp  ( adr c -- bmp ) zstring al_load_bitmap ;
: savebmp  ( bmp adr c -- ) zstring swap al_save_bitmap 0= abort" Allegro: Error saving bitmap." ;

0 constant FLIP_NONE
1 constant FLIP_H
2 constant FLIP_V
3 constant FLIP_HV

create oldblender  6 cells allot
: blend>  ( op src dest aop asrc adest -- )
    oldblender dup cell+ dup cell+ dup cell+ dup cell+ dup cell+ al_get_separate_blender
    al_set_separate_blender  r> call
    oldblender @+ swap @+ swap @+ swap @+ swap @+ swap @ al_set_separate_blender ;
: write-rgba  ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ZERO ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ZERO ;
: add-rgba    ALLEGRO_ADD ALLEGRO_ALPHA ALLEGRO_ONE  ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ONE  ;
: blend-rgba  ALLEGRO_ADD ALLEGRO_ALPHA ALLEGRO_INVERSE_ALPHA  ALLEGRO_ADD ALLEGRO_ONE ALLEGRO_ONE ;
blend-rgba al_set_separate_blender
