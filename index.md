# AllegroForthKit

This kit provides essential tools to code games and things with Allegro in an ANS Forth environment.

It can be referred to as AFKIT for short.

It's written to the DPANS94 standard.

Since no version of the Forth standard supports 100% of what's required to do this, and differences among standards-compliant Forth environments aren't accounted for by the standard, platform adapters are required to support each Forth system and the platforms they run on.  In most cases these adapters should be minimal apart from the external library bindings which could need substantial work to get running.

In any case, these docs assume you're using it on SwiftForth on Windows or Linux since that's what it was developed on.

## Downloads

AllegroForthKit is available on [Github](https://github.com/RogerLevy/AllegroForthKit/).

## Documentation

- [Basic Usage](basic-usage.md)
- [The Piston (the standard main loop)](piston.md)
- [Word Reference](words.md)
- [Dependency Reference](dependencies.md)

## TODO

- [Porting AFKIT](porting.md)
