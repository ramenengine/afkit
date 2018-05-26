$000100 [version] kb-ver
: klast  kblast swap al_key_down  ;
: kstate kbstate swap al_key_down ;
: kdelta >r  r@ klast #1 and  r> kstate #1 and  - ;
: kpressed  kdelta #1 = ;
: kreleased  kdelta #-1 = ;
: alt?   <alt> kstate     <altgr> kstate   or ;
: ctrl?  <lctrl> kstate   <rctrl> kstate   or ;
: shift? <lshift> kstate  <rshift> kstate  or ;
