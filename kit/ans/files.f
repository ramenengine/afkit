decimal

\ intent: create file and write string to the file
: file!  ( addr count filename c -- )  \ file store
  w/o create-file throw >r
  r@ write-file throw
  r> close-file throw ;

\ intent: fetch file contents into destination buffer
: @file  ( filename c dest -- size )  \ fetch file
  -rot r/o open-file throw >r
  r@ file-size drop throw r@ read-file throw
  r> close-file throw ;


\ system heap version

\ intent: fetch file contents into memory
: file@  ( filename c -- allocated-mem size )  \ file fetch
  r/o open-file throw >r
  r@ file-size throw d>s dup dup allocate throw dup rot
  r@ read-file throw drop
  r> close-file throw
  swap ;

\ dictionary version

\ intent: fetch file contents into dictionary
: file  ( filename c -- addr size )  \ file from
  file@  2dup here dup >r  swap  dup /allot  move  swap free throw  r> swap ;

\ intent: comma a file into the dictionary (same as file> except drops off returned values)
: file,  ( filename c -- )  \ file comma
  file 2drop ;


\ File path tools
: ending ( addr len char -- addr len )
   >r begin  2dup r@ scan
      ?dup while  2swap 2drop  #1 /string
   repeat  r> 2drop ;

: -EXT ( a n -- a n )   2DUP  [CHAR] . ENDING  NIP -  1-  0 MAX ;

[defined] linux [if]
: slashes  2dup  over + swap do  i c@ [char] \ = if  [char] / i c!  then  #1 +loop ;
: -filename ( a n -- a n )  slashes  2dup  [char] / ending  nip - ;
: -PATH ( a n -- a n )   slashes  [CHAR] / ENDING  0 MAX ;
[else]
: slashes  2dup  over + swap do  i c@ [char] / = if  [char] \ i c!  then  #1 +loop ;
: -filename ( a n -- a n )  slashes 2dup  [char] \ ending  nip - ;
: -PATH ( a n -- a n )   slashes  [CHAR] \ ENDING  0 MAX ;
[then]
