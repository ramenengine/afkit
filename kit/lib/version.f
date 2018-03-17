[undefined] [version] [if]
: [version]  ( n -- <ver> )
    depth 0 <= abort" Version number is required!"
    dup >r constant
    dup $FF0000 and r@ $FF0000 and <> abort" Incompatible major version!"
    $FF00 and r> $FF00 and <> if cr ." ::: WARNING: Potential minor version incompatibility --> " including -path type then ;
[then]
