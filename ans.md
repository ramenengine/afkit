# ANS Modules

These are modules located in `ans/`  that have no dependencies.  They are all loaded as part of the kit, which also depends on them.

## version.f

AFKIT comes with a simple versioning system to assist with installing library dependencies and resolving version conflicts.

It's implemented using a single definition.

```
: [version]  ( M m r M m r -- <versionname> )
```
Declare the version of the current file.

How to use:

Put [version] at the top of the main file of the package.  A package is a portable body of code.

When a file with versioning is included, you need to pass in a version code.  (You can circumvent this if needed by passing in 0.)

Versions are expressed as triplets MMmmrr M = major, m = minor, r = revision.  Example: $012003 = 1.20.3

A discrepancy in the Major version will prevent your project from compiling.

A minor version or revision # discrepency will just issue a warning.  This can help you identify culprits when debugging.

## files.f

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


## roger.f

Selected words are explained here.  The rest should be self-explanatory from the source.

```
: @+  ( a -- a+4 n )  fetch and increment
: for  ( n -- )  same as `0 do`
: ifill    ( addr count val - )  fill cells
: ierase   ( addr count -- ) erase cells
: imove    ( from to count -- ) move cells
: time?  ( xt -- )  time a word and display in microsecs
: :is  ( -- <name> <code> )  define a DEFER
```

```
: define  ( -- <name> )
```

Declare a vocabulary and set the current one to it.

```
: require ( filepath -- )
```
Conditional include.  If the file is already loaded, nothing happens.


## strops.f

Tools for concatenating strings and working with zero-terminated strings.

Here are examples of concatenation:

```
s" First part" s[ s", second part" +s ]s type
s" This is" s" the same" strjoin type
```

### Other string words

```
: input  ( adr c -- )
```

Get input from the input stream (keyboard) into a given address range.

```
: <filespec>  ( -- <rol> addr c )
```

Utility word for parsing file paths used by declaring words in the kit.