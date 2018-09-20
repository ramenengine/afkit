: zcount ( zaddr -- addr n )   dup dup if  65535 0 scan drop over - then ;
: zlength ( zaddr -- n )   zcount nip ;
: zplace ( from n to -- )   tuck over + >r  cmove  0 r> c! ;
: zappend ( from n to -- )   zcount + zplace ;
\ defer alert  ( a c -- )
: alert  type true abort ;
[undefined] third [if] : third  >r over r> swap ; [then]
[undefined] @+ [if] : @+  dup @ swap cell+ swap ; [then]
: u+  rot + swap ;  \ "under plus"
: ?lit  state @ if postpone literal then ; 
: do postpone ?do ; immediate
: for  s" 0 do" evaluate ; immediate
: allotment  here swap /allot ;
: move,   here over allot swap move ;
: h?  @ h. ;
: reclaim  h ! ;
: ]#  ] postpone literal ;
: <<  s" lshift" evaluate ; immediate
: >>  s" rshift" evaluate ; immediate
: bit  dup constant  1 lshift ;
: clamp  ( n low high -- n ) -rot max min ;
: ++  1 swap +! ;
: --  -1 swap +! ;
: and!  dup >r @ and r> ! ;
: or!   dup >r @ or r> ! ;
: xor!   dup >r @ xor r> ! ;
: @!  dup @ >r ! r> ;
: bounds  over + swap ;
: lastbody  last @ name> >body ;

\ WITHIN? - lo and hi are inclusive
: within? ( n lo hi -- flag )  over - >r - r> #1 + u< ;

: ifill  ( addr count val - )  -rot  0 do  over !+  loop  2drop ;
: ierase   0 ifill ;
: imove  ( from to count - )  cells move ;
: time?  ( xt -- ) ucounter 2>r  execute  ucounter 2r> d-  d>s  . ;

: kbytes  #1024 * ;
: megs    #1024 * #1024 * ;
: udup  over swap ;
: 2,  swap , , ;
: 3,  rot , swap , , ;
: 4,  2swap swap , , swap , , ;
: :is  :noname  postpone [  [compile] is  ] ;
: reverse   ( ... count -- ... ) 1+ 1 max 1 ?do i 1- roll loop ;
: cfill  fill ;

\ Random numbers
0 VALUE seed
: /rnd  ucounter drop to seed ;  /rnd
: random ( -- u ) seed $107465 * $234567 + DUP TO seed ;
: rnd ( n -- 0..n-1 ) random um* nip ;

\ vocabulary helper
: define  >in @  vocabulary  >in !  also ' execute definitions ;


\ on-stack vector stuff (roger)
: 2!  swap over cell+ ! ! ;
: 2@  dup @ swap cell+ @ ;
: 2+!  swap over cell+ +! +! ;
: 3@  dup @ swap cell+ dup @ swap cell+ @ ;
: 4@  dup @ swap cell+ dup @ swap cell+ dup @ swap cell+ @ ;
: 3!  dup >r  2 cells + !  r> 2! ;
: 4!  dup >r  2 cells + 2! r> 2! ;
: 2min  rot min >r min r> ;
: 2max  rot max >r max r> ;
: 2+  rot + >r + r> ;
: 2-  rot swap - >r - r> ;
: 2negate  negate swap negate swap ;
: 2clamp  ( x y lowx lowy highx highy -- x y ) 2>r 2max 2r> 2min ;

\ Word tools
: defined ( -- c-addr 0 | xt -1 | -- xt 1 )  bl word find ;
: exists ( -- flag )   defined 0 <> nip ;

\ Conditional INCLUDE
: require  ( -- <path> )
    >in @  exists if  drop  exit  then
    dup >r  >in !  include  r> >in !  create ;
: include  ( -- <path> )
    >in @  create  >in !  bl parse included ;

\ compile and exec
: :now  :noname  [char] ; parse evaluate  postpone ;  execute ;

