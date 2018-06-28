# Home

## Introduction

AllegroForthKit (AFKIT for short) provides a framework for making games and other things with Allegro 5 in standard Forth.

It's written to the DPANS94 standard.

Since no version of the Forth standard supports 100% of what's required to use Allegro, platform adapters are required to support each Forth system and the platforms they run on.  In most cases these adapters should be minimal apart from the external library bindings which could need substantial work to get running.

In any case, these docs assume you're using it on SwiftForth on Windows or Linux since that's what it was developed on.

AFKIT is a package containing ANS-compatible libraries, bindings for external libraries, core modules, and optional libraries.  (The words "module" and "library" are used interchangeably, but only in the sense that a library is a kind of module.)

## Downloads

AllegroForthKit is available on [Github](https://github.com/RogerLevy/AllegroForthKit/).

## Documentation

- [Basic Usage](basic-usage.md)
- [The Piston](piston.md) (the standard main loop)
- [Module Reference](words.md)
- [Dependency Reference](dependencies.md)

Explains the kit's dependencies.

## TODO

### [Porting AFKIT](porting.md)
### [Audio](audio.md)
### [IDE](ide.md)