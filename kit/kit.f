
\ Load external libraries
[undefined] EXTERNALS_LOADED [if]  \ ensure that external libs are only ever loaded once.
    s" kitconfig.f" file-exists [if]
        include kitconfig.f
    [else]
        .( Missing kitconfig.f!!!) QUIT
    [then]
    include kit/platforms.f

    true constant EXTERNALS_LOADED

    $F320000 'FPOPT !  \ hopefully fixes fixed point math on linux
    cd kit/lib/ffl
        ffling +order
            include ffl/dom.fs
            include ffl/b64.fs
        ffling -order
    cd ../../..
[then]

\ Load support libraries
include kit/lib/win/fpext      \ depends on FPMATH
include kit/lib/strops         \ ANS
include kit/lib/files          \ ANS
include kit/lib/roger          \ ANS

\ Load graphics window, input, and main loop
include kit/display          cr .( loaded display    )
include kit/input            cr .( loaded allegro input support words )
include kit/gfx              cr .( loaded graphics tools              )
include kit/piston           cr .( loaded the main loop               )

: empty  -display empty ;

+display
>ide
