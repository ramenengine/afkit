\ TODO: INCLUDING needs to be defined on each platform, else we have to define it here somehow

\ create incpath 256 allot
\ : including  ( -- adr c | 0 )
\     source-id -exit
\     source-id #-1 = if  0 exit  then
\     [in-platform] win [if]
\         source-id incpath #255 0 GetFinalPathNameByHandle drop
\     [then]
\     [in-platform] linux [if]
\
\     [then]
\ ;


\ Relative path tool
: along  ( adr c -- adr c )
    including -filename 2swap strjoin ;
