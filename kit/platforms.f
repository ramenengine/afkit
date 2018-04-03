: PARSE-WORD ( "<spaces>name" -- c-addr u )   /SOURCE OVER >R  BL SKIP DROP R> - >IN +!  BL PARSE ;
: [platform]     platform parse-word compare 0= ; immediate
: [in-platform]  platform parse-word search nip nip ; immediate

[in-platform] win32 [if]
    cr .( NOTICE: Audio and other addons will not work on Windows unless you copy all of the )
    cr .( dependency DLL's to your host Forth's bin folder. I tried everything and they just would not )
    cr .( work from the lib\ folder. I'm guessing it's a security measure. This shouldn't affect )
    cr .( released applications; so long as the DLL's are in the same folder as the turnkey executable,)
    cr .( they should load.  You can still load the Allegro DLL without doing this; you just won't )
    cr .( be able to play anything but WAV files.)
[then]


[in-platform] win32 [if] true constant win32 [then]
[in-platform] linux [if] true constant linux [then]

\ Platforms ------------------------------------------------------------------------------------------

\ SwiftForth
[in-platform] sf [if]
    true constant swiftforth
    [defined] win32 [if] include kit/plat/sfwin32.f [then]
    [defined] linux [if] include kit/plat/sflinux.f [then]
[then]


\ End platforms -------------------------------------------------------------------------------------
