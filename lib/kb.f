: klast     kblast swap al_key_down  ;
: kstate    kbstate swap al_key_down ;
: kdelta    >r  r@ kstate #1 and  r> klast #1 and  - ;
: pressed   kdelta #1 = ;
: released  kdelta #-1 = ;
: alt?      <alt> kstate     <altgr> kstate   or ;
: ctrl?     <lctrl> kstate   <rctrl> kstate   or ;
: shift?    <lshift> kstate  <rshift> kstate  or ;
