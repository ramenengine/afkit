\ this version simplifies game dev by making fixed point numbers THE DEFAULT.
\ the new format will be 20:12.
\   (that provides a range of roughly -0.5m~0.5m with a granularity of 1/4096)
\ NOTE TO SELF: this number system isn't meant to replace floats.  floats should
\   continue to be used where precision or wide range is needed.
\ the following bits of the Forth system will be modified:
\   literals will by default be interpreted as fixed point.  regardless of
\     if there is a decimal point.
\   to specify integer literals, suffix with #.
\   a new "base" for display will be added ( FIXED ) which
\     will affect .s . ? and friends
\ the following words will be redefined or otherwise altered
\   * / /mod .s . ?
\   ++ --
\   loop
\ the following words will remain untouched
\   + - mod
\   "compiler oriented words": cells allot /allot erase move fill
\ the following words will use prefixes to avoid collision with float words
\   pfloor pceil
\ additional words for conversion to other formats
\   1i 2i 3i 4i
\   f 1f 2f 3f 4f
\ stack diagrams
\   n = fixed-point
\   i = integer

[undefined] f+ [if]
requires fpmath
[then]

[undefined] +s [if]
include string-operations.f
[then]

12 constant /FRAC
$FFFFF000 constant INT_MASK
$00000FFF constant FRAC_MASK
\ 4096e fconstant FPGRAN
\ #define FPGRAN 4096e
: FPGRAN  s" 4096e" evaluate ; immediate
4096  constant PGRAN
$1000 constant 1.0
1.0 negate constant -1.0
variable ints  ints on  \ set/disable integer mode on both display and interpretation

wordlist constant fixpointing
fixpointing +order

: fixed   fixpointing +order  ints off decimal ;
: decimal fixpointing -order  ints on  decimal ;
: binary  fixpointing -order  ints on  binary ;
: hex     fixpointing -order  ints on  hex ;
: octal   fixpointing -order  ints on  octal ;


\ private
    \ SwiftForth/X86 only - arithmetic shift
    ICODE ARSHIFT ( x1 n -- x2 )
       EBX ECX MOV                      \ shift count in ecx
       POP(EBX)                         \ get new tos
       EBX CL SAR                       \ and shift bits right
       RET   END-CODE
    ICODE ALSHIFT ( x1 n -- x2 )
       EBX ECX MOV                      \ shift count in ecx
       POP(EBX)                         \ get new tos
       EBX CL SHL                       \ and shift bits right
       RET   END-CODE

\ NTS: keep these as one-liners, I might make them macros...
: s>p  " /FRAC alshift" evaluate ; immediate
: 2s>p  s>p swap s>p swap ;
\ : 1i  pgran / ;
: 1i  " /frac arshift" evaluate ; immediate
: 2i  swap 1i swap 1i ;
: 3i  rot 1i rot 1i rot 1i ;
: 4i  2i 2swap 2i 2swap ;
: f  s>f FPGRAN f/ ;
: 1f  f ;  \ not recommended, looks very similar to "if"
: 2f  swap f f ;
: 3f  rot f 2f ;
: 4f  2swap 2f 2f ;
: pfloor  INT_MASK and ;
: pceil   pfloor 1.0 + ;
: 2pfloor  pfloor swap pfloor swap ;
: 2pceil   pceil swap pceil swap ;
: f>p  FPGRAN f* f>s ;

definitions
\ NTS: keep these as one-liners, I might make them macros...
: *  ( n n -- n )  1f s>f f* f>s ;
previous definitions fixpointing +order
: p*  * ;
definitions
: /  ( n n -- n )  swap s>f 1f f/ f>s ;
: /mod  ( n n -- r q ) 2dup mod -rot / ;
: ++  1.0 swap +! ;
: --  -1.0 swap +! ;

: 2*  rot * >r * r> ;
: 2/  rot swap / >r / r> ;

: i.  . ;
: .   ints @ if  .  else  1f f.  then ;
: p.  . ;
: ?   @ . ;
: 2.  swap . . ;
: 3.  rot . 2. ;
: 2?  swap ? ? ;
: 3?  rot ? 2? ;

previous definitions fixpointing +order


\ --------------------------- swiftforth-specific -----------------------------
\ extend literals to support fixed-point
variable sign
: pconvert ( a -- 0 | a -1 ) ( -- | r )
   <sign>    ( a c f)  drop [char] - = sign !
   <digits>  ( a d n)  0= if 2drop drop 0 exit then d>f
   <dot>     ( a c f)  0= if fdrop 2drop 0 exit then drop
   <digits>  ( a d n)  -rot d>f t10** f/ f+
                       sign @ if fnegate then
\   <e>       ( a c f)  if fdrop 2drop 0 exit then drop
   -1 ;

: >pfloat ( caddr n -- true | false ) ( -- r )
   r-buf  r@ zplace
   r@ pconvert ( 0 | a\f ) if
      r> zcount + = dup ?exit fdrop exit
   then r> drop 0 ;

: pnumber? ( addr len 0 | p.. xt -- addr len 0 | p.. xt )
  dup ?exit drop
  2dup >pfloat if
    2drop
    FPGRAN f* (f>s) ['] literal
    exit
  then
  0 ;

\ decimal-point-less conversion
: pnumber2? (  addr len 0  |  ... xt  --  addr len 0  |  ... xt  )
  dup ?exit drop
  base @ 10 =  ints @ 0 = and  if
    2dup
      number? 1 = if
        nip nip  /FRAC lshift  ['] literal
        exit
      then
  then  0  ;

definitions
: .S ( ? -- ? )
  CR DEPTH 0> IF DEPTH 0 ?DO S0 @ I 1+ CELLS - @ . LOOP THEN
  DEPTH 0< ABORT" Underflow"
  FDEPTH ?DUP IF
    ."  FSTACK: "
    0  DO  I' I - 1- FPICK N.  LOOP
  THEN ;

previous definitions fixpointing +order


\ -------- Add fixed-point interpreter to SwiftForth -------
PACKAGE STATUS-TOOLS
public
[undefined] linux [if]
    : SB.BASE2  ( -- )
      ints @ 0 = if
        s" FIX"
      else
        BASE @ PSTK (.BASE)
      then
      1 SF-STATUS PANE-TYPE ;
    : SB.STACK2 ( -- )
      ints @ if
        PSTK Z(.S) ZCOUNT s[
      else
        s" " s[
        DEPTH 0 >= IF
          DEPTH 0 ?DO
            S0 @ I 1 + CELLS - @
            dup 0 < if s"  " +s then
            f 3 (f.) +s
          LOOP
        ELSE
          s" Underflow" +s
        THEN
      then
      FDEPTH ?DUP IF
        s"  FSTACK:" +s
        0 DO  I' I - 1 - FPICK 3 (f.) +s  LOOP
      THEN
      ]s 0 SF-STATUS PANE-RIGHT ;

    : STATUS.STACK2 ( -- )    SB.BASE2  SB.STACK2 ;

    ' status.stack2 is .stack
[then] \ not linux

' pnumber2? number-conversion >chain
' pnumber? number-conversion >chain

END-PACKAGE

\ ------------------------------------------------------------


decimal

fixpointing +order definitions
: cells  1i cells ;
: bytes  1i ;
: hwords 1i 1 lshift ;
: loop  " 1.0 +loop" evaluate ; immediate
: lshift  1i lshift ;
: rshift  1i rshift ;
: << lshift ;
: >> rshift ; 
previous definitions


: ?fixed  ?exit fixed ;
: include   ints @ >r  fixed include  r> ?fixed ;
: included  ints @ >r  fixed included  r> ?fixed ;
: import    ints @ >r  fixed import   r> ?fixed ;
: idiom     ints @ >r  idiom   r> ?fixed ;
[defined] /only [if]
    :noname [ is /only ] only forth ints @ not if fixpointing +order then ;
[then]
