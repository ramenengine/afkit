[platform] sflinux [if] \\ [then]

[platform] sfwin32 [if]
    include kit/dep/fmod5/fmod5.f
[then]

variable fmod

: -audio  \ TBD
;

: +audio  \ TBD
;

: initaudio
    fmod FMOD_System_Create
    fmod @ #32 0 0 FMOD_System_Init
;

: updateaudio \ necessary for callbacks and FMOD_NONBLOCKING to work
    fmod @ FMOD_System_Update
;

