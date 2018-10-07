[undefined] afkit-require [if] 
true constant afkit-require

: defined  ( -- <word> flag ) bl word find ;
: exists ( -- <word> flag )   defined 0 <> nip ;


\ Conditional INCLUDE
: include  ( -- <path> )
    >in @ >r  bl parse included  r> >in !  create ;
: require  ( -- <path> )
    >in @  exists if drop exit then  >in !
    include ;

[then]