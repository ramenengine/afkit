[undefined] [version] [if]
: packver  swap 8 lshift or swap 24 lshift or ;
: [version]  ( M m R M m R -- )
    depth 6 < abort" Version number is required!"
    packver >r packver r>
    over 0 = if 2drop exit then
    swap #8 rshift swap #8 rshift > abort" Incompatible version!"
;
[then]

\ versions are expressed as three values M = major, m = minor, R = revision
\ in documentation, they're expressed as M.m.r
\ Major versions are always source breaking
\ Minor versions are generally additions, but also sometimes deletions, renames, and semantic changes
\ Revisions are bugfixes, and benign tweaks such as dox and housekeeping


