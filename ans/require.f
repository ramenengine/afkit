[undefined] require [if] 

[undefined] exists [if]
: exists ( -- flag )   defined 0 <> nip ;
[then]

\ Conditional INCLUDE
: require  ( -- <path> )
    >in @  exists if  drop  exit  then
    dup >r  >in !  include  r> >in !  create ;
: include  ( -- <path> )
    >in @  create  >in !  bl parse included ;

[then]