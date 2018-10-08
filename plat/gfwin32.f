: platform  s" gfwin32" ;
: attribute  drop ;

variable gforth-path  fpath @ gforth-path !


create path 256 allot
: append  2DUP 2>R  COUNT + SWAP MOVE  2R> C+! ;
: combined  dup >r  place  r@ append  r> count ;
: included  s" ~+/" path combined included ;
: include  ( -- <path> )
    >in @ >r  bl parse included  r> >in !  create ;
: depend  ( -- <path> )
    >in @  exists if drop exit then  >in !
    include ;
    
create cmd 256 allot
: cd  0 parse s" chdir " cmd combined system ;

: h.  hex . decimal ;


quit
\ include afkit/ans/ffl/sfwin32/ffl.f   \ FFL: DOM; FFL loads FPMATH
include afkit/dep/allegro5/allegro-5.2.x.f

\ include afkit/plat/sf.f
