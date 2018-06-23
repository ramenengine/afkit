# AllegroForthKit

AllegroForthKit (AFKIT for short) provides a framework for making games and other things with Allegro 5 in standard Forth.

It's written to the DPANS94 standard.

Since no version of the Forth standard supports 100% of what's required to use Allegro, platform adapters are required to support each Forth system and the platforms they run on.  In most cases these adapters should be minimal apart from the external library bindings which could need substantial work to get running.

In any case, these docs assume you're using it on SwiftForth on Windows or Linux since that's what it was developed on.

## Downloads

AllegroForthKit is available on [Github](https://github.com/RogerLevy/AllegroForthKit/).

## Documentation

### [Basic Usage](basic-usage.md)

Describes how to get started writing programs.

### [The Piston (the standard main oop)](piston.md)

The standard game loop.

### [Module Reference](words.md)

Explains various modules and words. (Not a comprehensive glossary.)

### [Dependency Reference](dependencies.md)

Explains the kit's dependencies.

## TODO

### [Porting AFKIT](porting.md)
### [Audio](audio.md)
### [IDE](ide.md)