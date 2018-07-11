: PARSE-WORD ( "<spaces>name" -- c-addr u )   /SOURCE OVER >R  BL SKIP DROP R> - >IN +!  BL PARSE ;
: [platform]     platform parse-word compare 0= ; immediate
: [in-platform]  platform parse-word search nip nip ; immediate

[in-platform] win32 [if]
    cr .( NOTE TO DEVELOPERS: )
    cr .( The audio codec and other addons will not work on Windows unless )
    cr .( you copy all of the Allegro DLL's to your host Forth's bin folder. )
    cr
    cr .( This is likely a security measure of Windows. )
    cr
    cr .( This shouldn't affect released applications so long as the DLL's are in the )
    cr .( same folder as the game exe.)
    cr 
    cr .( You can still load the Allegro DLL without doing this; you just won't )
    cr .( be able to play anything but WAV files and you might not be able to )
    cr .( do other things.)
    cr
[then]
\ " \ <--- this is to heal Komodo Edit's string highlighting bug 

[in-platform] win32 [if] true constant win32 [then]
[in-platform] linux [if] true constant linux [then]
