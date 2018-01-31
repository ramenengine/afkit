decimal \ important

[undefined] #defined [if]
: #define  create  0 parse bl skip evaluate ,  does> @ ;
: #fdefine  create  0 parse bl skip evaluate sf,  does> sf@ ;
[then]

: field  create over , + does> @ + ;
: var  cell field ;
: fload   include ;
: ?constant  constant ;

\ intent: speeding up some often-used short routines
\ usage: macro:  <some code> ;  \ entire declaration must be a one-liner!
: macro:  ( - <code> ; )  \ define a macro; the given string will be evaluated when called
  create immediate
  [char] ; parse string,
  does> count evaluate ;


#define ALLEGRO_VERSION          5
#define ALLEGRO_SUB_VERSION      2
#define ALLEGRO_WIP_VERSION      3
#define ALLEGRO_RELEASE_NUMBER   0


[defined] linux [if]
    : linux-library  library ;
    library /usr/lib/i386-linux-gnu/liballegro.so.5.2
    library /usr/lib/i386-linux-gnu/liballegro_memfile.so.5.2
    library /usr/lib/i386-linux-gnu/liballegro_primitives.so.5.2
    library /usr/lib/i386-linux-gnu/liballegro_acodec.so.5.2
    library /usr/lib/i386-linux-gnu/liballegro_audio.so.5.2
    library /usr/lib/i386-linux-gnu/liballegro_color.so.5.2
    library /usr/lib/i386-linux-gnu/liballegro_font.so.5.2
    library /usr/lib/i386-linux-gnu/liballegro_image.so.5.2
    library /usr/lib/i386-linux-gnu/liballegro_font.so.5.2
[else]
    cd kit/dlib/sfwin32/allegro5
    : linux-library  0 parse 2drop ;
    [defined] allegro-debug [if]
      library allegro_monolith-debug-5.2.dll
    [else]
      library allegro_monolith-5.2.dll
    [then]
    cd ../../../..
    warning off
[then]

ALLEGRO_VERSION 24 lshift
ALLEGRO_SUB_VERSION 16 lshift or
ALLEGRO_WIP_VERSION 8 lshift or
ALLEGRO_RELEASE_NUMBER or
constant ALLEGRO_VERSION_INT

: void ;

: /* postpone \ ; immediate

\ ----------------------------- load files --------------------------------

include kit/dlib/sfwin32/allegro5/01_allegro5_general.f
include kit/dlib/sfwin32/allegro5/02_allegro5_events.f
include kit/dlib/sfwin32/allegro5/03_allegro5_keys.f
include kit/dlib/sfwin32/allegro5/04_allegro5_audio.f
include kit/dlib/sfwin32/allegro5/05_allegro5_graphics.f
include kit/dlib/sfwin32/allegro5/06_allegro5_fs.f

\ =============================== END ==================================

warning on

cr .( Allegro 5.2 )
