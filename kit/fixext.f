
\ degrees are clockwise: left hand thumb is 0, wrist is 90

\ advanced fixed point math
: cos  ( deg -- n )   1f cos f>p ;
: sin  ( deg -- n )   1f sin f>p ;
: asin  ( n -- deg )  1f fasin r>d f>p ;
: acos  ( n -- deg )  1f facos r>d f>p ;
: lerp  ( src dest factor -- )  >r over - r> * + ;
: anglerp  ( src dest factor -- )
  >r  over -  360 mod  540 +  360 mod  180 -  r> * + ;
: sqrt  ( n -- n )  1f fsqrt f>p ;
: atan  ( n -- n )  1f fatan f>p ;
: atan2 ( n n -- n )  2f fatan2 f>p ;
: log2  ( n -- n )  1e 1f y*log2(x) f>p ;  \ binary logarithm (for fixed-point)
: rescale  ( n min1 max1 min2 max2 -- n )  \ transform a number from one range to another.
  locals| max2 min2 max1 min1 n |
  n min1 -  max1 min1 -  /  max2 min2 -  *  min2 + ;

\ advanced fixed point 2d vector math
: uvector  ( deg -- x y )   >r  r@ cos  r> sin ;  \ get unit vector from angle
: vector  ( deg len -- x y )  >r  uvector  r> dup 2* ;
: angle  ( x y -- deg )  \ get angle of vector
  2dup or not if  2drop 0  exit then  1f 1f fatan2 r>d f>p ;
: magnitude  ( x y -- n )  2f fdup f* fswap fdup f* f+ fsqrt f>p ;
: normalize  ( x y -- x y )  2dup 0 0 d= ?exit  2dup magnitude dup 2/  1 1 2+ ;
: proximity  ( x y x y -- n ) 2swap 2- magnitude ;   \ distance between two vectors
: hypot  ( x y -- n )  1f fdup f* 1f fdup f* f+ fsqrt f>p ;
: dotp  ( x y x y - n )  -rot ( b.x a.y ) * >r  ( a.x b.y ) *  r> - ;
: 2scale  2* ;
: uscale  dup 2* ;
: 2rotate  ( x y deg -- x y )
  dup cos  swap sin  locals| sin(ang) cos(ang) y x |
  x cos(ang) * y sin(ang) * -
  x sin(ang) * y cos(ang) * + ;
: radians  1f  d>r  f>p ;
: c>p  ( c - n )  \ convert from 0...255 (byte) to 0...1.0 (fixed)
  4 <<  1 $ff0 */ ;
: byt  dup $ff and c>p swap 8 >> ;
: 4reverse   swap 2swap swap ;
: 3reverse   swap rot ;
: >rgba  ( val -- r g b a ) byt byt byt byt drop >r 3reverse r> ;
: >rgb   ( val -- r g b )  byt byt byt drop 3reverse ;
