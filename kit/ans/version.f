[undefined] [version] [if]
: [version]  ( n n -- <versionname> )
    depth 2 < abort" Version number is required!"
    over 0 = if 2drop bl word drop exit then
    dup >r constant
    dup $FF0000 and r@ $FF0000 and <> abort" Incompatible major version!"
    $FF00 and r> $FF00 and <> if cr ." ::: WARNING: Potential minor version incompatibility --> " including -path type then ;
[then]

\ versions are expressed in source as BCD values MMmmrr M = major, m = minor, r = revision
\ in documentation, they're expressed as M.m.r
\ Major versions are always source breaking
\ Minor versions are generally additions, but also sometimes deletions, renames, and semantic changes
\ Revisions are bugfixes, non-source-breaking changes, documentation, reorganization etc
\ Only a discrepancy in the Major version will prevent your project from compiling.
\ A minor version discrepency will just issue a warning.  This can help you identify culprits.

