cd kit/dep/zlib
[defined] linux [if]
    library libz.so
[else]
    library libzlib
[then]
cd ../../..

function: compress ( dest-adr &destlen-double src-adr srclen-lo srclen-high -- result )
function: uncompress ( dest-adr &destlen-double src-adr srclen-lo srclen-high -- result )
