\ Parameter enclosures
\ a simple runtime relative stack depth checking mechanism.

\ example:
\   1( 123 )      \ stack ok, nothing happens
\   1( 123 321 )  \ throws an error
\   1( )          \ throws an error

: 1(  ( - )  s" depth >r" evaluate ; immediate
: (stackerr)  - #1 <> abort" stack check error" ;
: )   ( ... - ... )  s" depth r> (stackerr) " evaluate ; immediate

