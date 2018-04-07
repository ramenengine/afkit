[defined] [section] [if] \\ [then]
create section$  256 /allot
: (reload)  ( -- <file> <section> )
    >in @   bl word drop  bl word count 2dup upcase section$ place  >in !  include
    bl word drop ;
: reload  ( -- <file> <section> )
    ['] (reload) catch  section$ off  throw ;
: [section]
    section$ c@ 0= if bl word drop exit then
    bl word count 2dup upcase section$ count compare 0= ?exit
    begin  bl word count  2dup upcase
        s" [SECTION]" compare 0= if recurse exit then
    refill 0= until ;
