\ Allegro's audio API freaking sucks, so this is here just for people who don't want to
\ worry about FMOD licensing.   ($100 one-time fee for "indie" programmers w/ revenue <=$250k )
\ Allegro's audio API has been loaded already, so we don't load it here.

0 value mixer

: -audio
    mixer 0 al_set_mixer_playing drop
;

: +audio
    #16 al_reserve_samples not if  " Allegro: Error reserving samples." alert -1 abort  then
    al_get_default_mixer to mixer
    mixer #1 al_set_mixer_playing drop
;

: init-audio
    al_init_acodec_addon not if  " Allegro: Couldn't initialize audio codec addon." alert -1 abort  then
    al_install_audio not if  " Allegro: Couldn't initialize audio." alert -1 abort  then
    +audio
;

: audio-update
;
