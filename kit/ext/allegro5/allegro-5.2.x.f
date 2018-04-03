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

ALLEGRO_VERSION 24 lshift
ALLEGRO_SUB_VERSION 16 lshift or
ALLEGRO_WIP_VERSION 8 lshift or
ALLEGRO_RELEASE_NUMBER or
constant ALLEGRO_VERSION_INT

cd kit
[defined] linux [if]
    create libcmd 256 allot
    : linux-library
        s" library ext/allegro5/5.2.2/" libcmd place
        0 parse libcmd append
        s" .so.5.2.2" libcmd append
        libcmd count evaluate
    ;
    linux-library liballegro
    linux-library liballegro_memfile
    linux-library liballegro_primitives
    linux-library liballegro_acodec
    linux-library liballegro_audio
    linux-library liballegro_color
    linux-library liballegro_font
    linux-library liballegro_image
    linux-library liballegro_font
[else]
    : linux-library  0 parse 2drop ;
    [defined] allegro-debug [if]
      library ext/allegro5/5.2.3/allegro_monolith-debug-5.2.dll
    [else]
      library ext/allegro5/5.2.3/allegro_monolith-5.2.dll
    [then]
    warning off
[then]
cd ..

: void ;

: /* postpone \ ; immediate

\ ----------------------------- load files --------------------------------
: [COMPATIBLE]   ( ver subver -- )
   16 lshift swap 24 lshift or  ALLEGRO_VERSION_INT $ffff0000 and < if 0 parse 2drop then ;

include kit/ext/allegro5/allegro5_01_general.f
include kit/ext/allegro5/allegro5_02_events.f
include kit/ext/allegro5/allegro5_03_keys.f
include kit/ext/allegro5/allegro5_04_audio.f
include kit/ext/allegro5/allegro5_05_graphics.f
include kit/ext/allegro5/allegro5_06_fs.f

\ =============================== END ==================================

warning on

cr .( Allegro 5.2 )
