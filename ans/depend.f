[undefined] depend [if] 

: defined  ( -- <word> flag ) bl word find ;
: exists ( -- <word> flag )   defined 0 <> nip ;

\ Conditional INCLUDE
: include  ( -- <path> )
    >in @ >r  bl parse included  r> >in !  create ;
: depend  ( -- <path> )
    >in @  exists if drop exit then  >in !
    include ;

[then]