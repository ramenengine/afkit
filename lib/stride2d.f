: stride2d  ( xt x y w h stridew strideh -- )  ( x y -- )
    locals| sh sw h w y x xt |
    h #1 + y +  y do
        w #1 + x +  x do
            i j  xt execute
        sw +loop
    sh +loop ;

: break2d  ( xt pen=xy x2 y2 stridew strideh -- )  ( pen=xy w h -- )
    locals| sh sw y2 x2 xt |
    penx @
    y2 #1 + peny @  do
        x2 #1 + over do
            i j at  sw sh  x2 y2 i j 2- 2min  xt execute
        sw +loop
    sh +loop
    drop ;
