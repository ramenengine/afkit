[undefined] [version] [if]
: packver  swap 8 lshift or swap 24 lshift or ;
: [version]  ( M m R M m R -- )
    depth 6 < abort" Version number is required!"
    packver >r packver r>
    over 0 = if 2drop exit then
    2dup
    swap $ff000000 and swap $ff000000 and <> abort" Incompatible major version!"
    swap $00ffff00 and swap $00ffff00 and 2dup > abort" Incompatible minor version!"
    < if  cr #2 attribute ." Warning: Potentially incompatible minor version."  #0 attribute  then
;
[then]

\ versions are expressed as three values M = major, m = minor, R = revision
\ in documentation, they're expressed as M.m.r
\ Major versions are always source breaking
\ Minor versions are generally additions, but also sometimes deletions, renames, and semantic changes
\ Revisions are bugfixes, and benign tweaks such as dox and housekeeping


