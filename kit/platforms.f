cr .( NOTICE: Audio and other addons will not work on Windows unless you copy all of the )
cr .( dependency DLL's to your host Forth's bin folder. I tried everything and they just would not )
cr .( work from the lib\ folder. I'm guessing it's a security measure. This shouldn't affect )
cr .( released applications; so long as the DLL's are in the same folder as the turnkey executable,)
cr .( they should load.  You can still load the Allegro DLL without doing this; you just won't )
cr .( be able to play anything but WAV files.)

: PARSE-WORD ( "<spaces>name" -- c-addr u )   /SOURCE OVER >R  BL SKIP DROP R> - >IN +!  BL PARSE ;
: [platform]  parse-word platform compare 0= ;
: [in-platform]  parse-word platform search nip nip ;
defer system
[platform] sfwin32 [if] true constant win32 [then]
[platform] sflinux [if] true constant linux [then]
[in-platform] sf   [if] true constant swiftforth  :noname s" swiftforth" ; is system [then]
: [system]  parse-word system compare 0= ;
[platform] sfwin32 [if] include kit/plat/sfwin32.f [then]
