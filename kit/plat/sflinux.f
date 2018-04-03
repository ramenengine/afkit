include kit/ans/ffl/sflinux/ffl.f   \ FFL: DOM; FFL loads FPMATH
include kit/ext/allegro5/allegro-5.2.x.f

library libX11.so

function: XOpenDisplay ( zdisplayname -- display )
function: XDefaultScreen ( &display -- display )

function: XSync ( display discard -- )
function: XMapWindow ( display window -- )
function: XRaiseWindow ( display  window -- )

function: XSetInputFocus ( display window revert time -- )
function: XGetInputFocus ( display &window &revert -- )