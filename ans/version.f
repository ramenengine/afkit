[undefined] [version] [if]
: packver  swap 8 lshift or swap 24 lshift or ;
: [version]  ( M m R M m R -- )
    depth 6 < abort" Version number is required!"
    packver >r packver r>
    over 0 = if 2drop bl word drop exit then
    >r
    dup $FF000000 and r@ $FF000000 and <> abort" Incompatible major version!"
    $FFFF00 and r> $FFFF00 and <> if
        bold
        cr ." ::: WARNING: Potential minor version incompatibility --> " including -path type
        normal
    then ;
[then]

\ versions are expressed as three values M = major, m = minor, R = revision
\ in documentation, they're expressed as M.m.r
\ Major versions are always source breaking
\ Minor versions are generally additions, but also sometimes deletions, renames, and semantic changes
\ Revisions are bugfixes, and benign tweaks such as dox and housekeeping
\ Only a discrepancy in the Major version will prevent your project from compiling.
\ A minor version discrepency will just issue a warning.  This can help you identify culprits.


