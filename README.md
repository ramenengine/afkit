# Introduction

AllegroForthKit \(aka AFKit\) provides a framework for making games \(and other apps\) with Allegro 5 in standard Forth.

It's written to the DPANS94 standard.

It contains ANS-compatible libraries, bindings for external libraries, core modules, and optional libraries. \(The words "module" and "library" are used interchangeably, but only in the sense that a library is a kind of module.\)

### Standard-Compliant Modules

These files can be loaded on any ANS Forth system and are used to help build the rest of the kit.

| File | Description |
| :--- | :--- |
| [version.f](ans.md#versionf) | Versioning |
| [files.f](ans.md#filesf) | File utilities |
| [roger.f](ans.md#rogerf) | Roger Levy's toolbelt |
| [section.f](ans.md#sectionf) | Load a specific section of a source file |
| [strops.f](ans.md#stropsf) | Concatenate strings and work with zero-terminated strings. |

