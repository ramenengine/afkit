# ANS Modules

These are modules that have no dependencies.  They are all loaded as part of the kit, which depends on them.

## Files

```
: file!  ( addr count filename c -- )  \ file store
: @file  ( filename c dest -- size )  \ fetch file
: file@  ( filename c -- allocated-mem size )  \ file fetch
: file  ( filename c -- addr size )
: file,  ( filename c -- )  \ file comma
: ending ( addr len char -- addr len )
: -ext ( a n -- a n )  minus extension
: -filename ( a n -- a n )  minus  filename
: -path ( a n -- a n )  minus path
```


## Roger

Selected words are explained here.  The rest should be self-explanatory from the source. (roger.f)

```
: @+  ( a -- a+4 n )  fetch and increment
: for  ( n -- )  same as `0 do`
: ifill    ( addr count val - )  fill cells
: ierase   ( addr count -- ) erase cells
: imove    ( from to count -- ) move cells
: time?  ( xt -- )  time a word and display in microsecs
:is  ( -- <name> <code> )  define a DEFER
```

```
: define  ( -- <name> )
```

Declare and define a vocabulary at once.

```
: require ( filepath -- )
```
Conditional include.  If the file is already loaded, nothing happens.

## Section

This facility is for loading sections of files.  First define sections in your code like this:

```
[section] a
...
[section] b
...
[section] c
...
```

Then, you can (re-)load individual sections from the Forth prompt:

```
just <file> <section>
```

One nifty use for this is if you want to reload part of a module you are testing, but maintain the state of the module's variables.

*All of the sections of your code* should be labeled with `[section]`, including the top of the file.  Otherwise `just` will load the top of the file every time.

## Strops

Tools for concatenating strings and working with zero-terminated strings.

Here are examples of concatenation:

```
s" First part" s[ s", second part" +s ]s type
s" This is" s" the same" strjoin type
```

#### Other string words

```
: input  ( adr c -- )
```

Get input from the input stream (keyboard) into a given address range.

```
: <filespec>  ( -- <rol> addr c )
```

Utility word for parsing file paths used by declaring words in the kit.