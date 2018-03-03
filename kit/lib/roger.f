: "  postpone s" ; immediate
: zcount ( zaddr -- addr n )   dup dup if  65535 0 scan drop over - then ;
: zlength ( zaddr -- n )   zcount nip ;
: zplace ( from n to -- )   tuck over + >r  cmove  0 r> c! ;
: zappend ( from n to -- )   zcount + zplace ;
defer alert  ( a c -- )
[undefined] third [if] : third  >r over r> swap ; [then]
[undefined] @+ [if] : @+  dup @ swap cell+ swap ; [then]
: u+  rot + swap ;  \ "under plus"
: ?lit  state @ if postpone literal then ; immediate
: do postpone ?do ; immediate
: for  " 0 do" evaluate ; immediate
: buffer  here swap /allot ;
: move,   here over allot swap move ;
: h?  @ h. ;
: reclaim  h ! ;
: ]#  ] postpone literal ;
: <<  " lshift" evaluate ; immediate
: >>  " rshift" evaluate ; immediate
: bit  dup constant  1 << ;
: clamp  ( n low high -- n ) -rot max min ;
[defined] locate [if] : l locate ; [then]

: ifill  ( c-addr count val - )  -rot  0 do  over !+  loop  2drop ;
: ierase   0 ifill ;
: imove  ( from to count - )  cells move ;
: time?  ( xt -- ) ucounter 2>r  execute  ucounter 2r> d-  d>s  . ;

: kbytes  #1024 * ;
: megs    #1024 * 1024 * ;
: udup  over swap ;
: 2,  swap , , ;
: 3,  rot , swap , , ;
: 4,  2swap swap , , swap , , ;
: :is  :noname  postpone [  [compile] is  ] ;
: 2move  ( src /pitch dest /pitch #rows /bytes -- )
  locals| #bytes #rows destpitch dest srcpitch src |
  #rows 0 do
    src dest #bytes move
    srcpitch +to src  destpitch +to dest
  loop ;
: reverse   ( ... count -- ... ) 1+ 1 max 1 ?do i 1- roll loop ;

