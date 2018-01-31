[platform] sfwin32 [if]
    include kit/dlib/sfwin32/fmod5/fmod5
[then]

variable fmod

: -audio  \ TBD
;

: +audio  \ TBD
;

: init-audio
    fmod FMOD_System_Create
    fmod @ #32 0 0 FMOD_System_Init
;

: audio-update  \ necessary for callbacks and FMOD_NONBLOCKING to work
    fmod @ FMOD_System_Update
;

