$000100 [version] xml-ver

\ XML reading tools

: parsexml ( adr len -- dom-rootnode )
    dom-new >r  true r@ dom-read-string 0= throw  r> dom>iter nni-root ;

: loadxml  ( adr c -- dom-rootnode )  file@  2dup parsexml  >r  drop free throw  r> ;


define xmling
    : value@  ( node -- adr c )  dom>node>value str-get ;
    : istype  ( node type -- node flag )  over dom>node>type @ = ;
    : named  ( node adr c -- node flag ) third dom>node>name str-get compare 0= ;
    : >first  nnn>children dnl>first @ ;
    : >next  ( node -- node|0 )  nnn>dnn dnn-next@ ;

    : stash   2dup pocket place ;
    : ?print  dup if  pocket count type space  then ;
previous definitions

also xmling

: xmlname  dom>node>name str-get ;

\ get # of child elements of given name
: xmlcount  ( node adr c -- n ) 0 locals| n c adr |
    >first begin ?dup while  dom.element istype if  adr c named if  1 +to n  then  then
    >next  repeat  n ;

: (find)  ( node adr c type -- node | 0 )  locals| type c adr |
    begin dup while  type istype if  adr c named ?exit  then  >next  repeat  ;

\ get next sibling of given name
: xmlnext  ( node adr c -- node | 0 )  rot >next -rot dom.element (find) ;

\ get first child of given name
: xmlfirst  ( node adr c -- node | 0 )  rot >first -rot dom.element (find) ;

\ get value of an attribute as a string
: xmlvalue  ( node adr c -- adr c true | 0 )
    rot >first -rot dom.attribute (find) if  value@ true  else  false  then ;

\ get text content of a node
: xmltext  ( node -- adr c | 0 )
    >first begin dup while  dom.text istype if  value@ exit  then  >next repeat ;

previous
