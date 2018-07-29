: keydown   over #5 rshift #1 + cells + @ swap #31 and #1 swap lshift and 0<> ;
: klast     kblast keydown ;
: kstate    kbstate keydown ;
: kdelta    >r  r@ kstate #1 and  r> klast #1 and  - ;
: pressed   kdelta #1 = ;
: released  kdelta #-1 = ;
: alt?      <alt> kstate     <altgr> kstate   or ;
: ctrl?     <lctrl> kstate   <rctrl> kstate   or ;
: shift?    <lshift> kstate  <rshift> kstate  or ;
