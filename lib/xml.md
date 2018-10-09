# XML

xml.f provides basic XML file reading support.  

Most of the words are kept within their own vocabulary, called `xmling`.

```text
: parsexml ( adr len -- dom ) Load DOM from XML text in memory
: loadxml  ( adr c -- dom nnn-root ) Load DOM from XML file and fetch its root node

define xmling

    : value@  ( dom-nnn -- adr c )  Get node (tag or attribute) value
    : istype  ( dom-nnn type -- dom-nnn flag )  Check node type
    : named?  ( dom-nnn adr c -- dom-nnn flag ) Check node name
    : >first ( dom-nnn -- dom-nnn|0 )  Get first child node
    : >next  ( dom-nnn -- dom-nnn|0 )  Get next sibling node
    : #elements  ( dom-nnn adr c -- n ) get # of child elements with a given name
    : element  ( dom-nnn n adr c -- dom-nnn|0 ) get child element N with a given name
    : attr?  ( dom-nnn name c -- flag )  check if element has an attribute
    : val  ( dom-nnn name c -- val c ) get value of an attribute as a string
    : pval  ( dom-nnn name c -- n ) fixed point
    : ival  ( dom-nnn name c -- # ) integer
    : text  ( dom-nnn -- text c | 0 ) get the text body of an element 
    : eachel  ( dom-nnn xt -- ) ( dom-nnn -- ) itterate on children elements
    : eachel>  ( dom-nnn -- <code> )  ( dom-nnn -- ) 
    : that's  ( dom-nnn -- <name> dom-nnn ) early-out if element isn't given namee
```

