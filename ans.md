# Standard-Compliant Modules

The standard-compliant modules are located in `ans/` and have no dependencies.

These files can be loaded on any ANS Forth system and are used to help build the rest of the kit.

| File | Description |
| :--- | :--- |
| [depend.f](ans.md#depend-f) | Conditional include |
| [version.f](ans.md#version-f) | Versioning |
| [files.f](ans.md#files-f) | File utilities |
| [roger.f](ans.md#roger-f) | Common toolbelt |
| [strops.f](ans.md#strops-f) | Concatenate strings and work with zero-terminated strings. |

## depend.f

This file provides `depend` which will load a given source file only if it hasn't been already loaded.  It works the same as `include`.

It also extends `include` to play well with `depend`.

## version.f

AFKIT comes with a simple versioning system based on a semver-like version number.

### How to use the versioning system

Put a version declaration at the top of the main file of the package.  The declaration looks something like this:

```text
#1 #0 #0 [version] [packagename]
```

And here is how to load the package and check the version:

```text
depend package.f
#1 #0 #0 [packagename] [checkver]
```

`[checkver]` compares the given numbers to the numbers outputted by `[packagename]` . 

The first number is the Major version and must match the package's.  The second is the Minor version, and the last number is the Revision.  The Minor version represents  potentially code-breaking changes and the Revision represents bugfixes and additions.  If the Minor version or the Revision is greater than the package's, compilation will be aborted.  If the Minor version is less than the package's a warning will be printed.  No warning is printed if the Revision is less than the package's.

## files.f

```text
: file!  ( addr count filename c -- )  \ file store
: @file  ( filename c dest -- size )  \ fetch file
: file@  ( filename c -- allocated-mem size )  \ file fetch
: file  ( filename c -- addr size )
: file,  ( filename c -- )  \ file comma
: ending ( addr len char -- addr len )
: -ext ( a n -- a n )  remove file extension
: -filename ( a n -- a n )  remove filename
: -path ( a n -- a n )  remove path portion
```

## roger.f

Selected words are explained here. The rest should be self-explanatory from the source.

```text
: @+  ( a -- a+4 n )  fetch and increment
: for  ( n -- )  same as `0 do`
: ifill    ( addr count val - )  fill cells
: ierase   ( addr count -- ) erase cells
: imove    ( from to count -- ) move cells
: time?  ( xt -- )  time a word and display in microsecs
: :is  ( -- <name> <code> )  define a DEFER
```

```text
: define  ( -- <name> )
```

Declare a vocabulary and set the current one to it.

```text
: require ( filepath -- )
```

Conditional include. If the file is already loaded, nothing happens.

## strops.f

Tools for concatenating strings and working with zero-terminated strings.

Here are examples of concatenation:

```text
s" First part" s[ s", second part" +s ]s type
s" This is" s" the same" strjoin type
```

### Other string words

```text
: input  ( adr c -- )
```

Get input from the input stream \(keyboard\) into a given address range.

```text
: <filespec>  ( -- <rol> addr c )
```

Utility word for parsing file paths used by declaring words in the kit.

