$000100 [version] xml-ver

\ XML reading tools

: parsexml ( adr len -- dom )
   dom-new >r  true r@ dom-read-string 0= throw  r> ;

: loadxml  ( adr c -- dom nnn-root )
    file@  2dup parsexml -rot  drop free throw  dup  dom>tree nnt-root@ ;


define xmling
    : value@  ( dom-nnn -- adr c )  dom>node>value str-get ;
    : istype  ( dom-nnn type -- dom-nnn flag )  over dom>node>type @ = ;
    : named  ( dom-nnn adr c -- dom-nnn flag ) third dom>node>name str-get compare 0= ;
    : >first  nnn>children dnl>first @ ;
    : >next  ( dom-nnn -- dom-nnn|0 )  nnn>dnn dnn-next@ ;

    \ : stash   2dup pocket place ;
    \ : ?print  dup if  pocket count type space  then ;
    \ : xmlname  dom>node>name str-get ;

    \ get # of child elements of given name
    : #elements  ( dom-nnn adr c -- n ) 0 locals| n c adr |
        >first begin ?dup while  dom.element istype if  adr c named if  1 +to n  then  then
        >next  repeat  n ;

    : (find)  ( dom-nnn adr c type -- dom-nnn | 0 )  locals| type c adr |
        begin dup while  type istype if  adr c named ?exit  then  >next  repeat ;

    : findchild  2>r >r >first r> 2r> (find) ;

    \ : next  ( dom-nnn adr c -- dom-nnn | 0 )      \ get next element with given name
    \    rot >next -rot dom.element (find) ;

    : element  ( dom-nnn c n adr -- dom-nnn )
        locals| c adr n |
        adr c dom.element findchild ?dup ?exit
        >next
        n 1 = abort" XML element not found"
        n 1 - for  adr c dom.element (find) dup 0= abort" XML element not found"  loop ;

    : attr?  dom.attribute findchild 0<> ;

    : val  ( dom-nnn adr c -- adr c )       \ get value of an attribute as a string
        dom.attribute findchild dup 0= abort" XML attribute not found"
        value@ ;

    : pval  ( dom-nnn adr c -- n )  val evaluate ;

    : text  ( dom-nnn -- adr c | 0 )  " " dom.text findchild value@ ;

    : eachelement>  ( dom-nnn -- <code> )  ( dom-nnn -- )
        r> swap >first
        begin dup while  dom.element istype if
            2dup 2>r  swap call  2r>
        then   >next  repeat  2drop ;

only forth definitions