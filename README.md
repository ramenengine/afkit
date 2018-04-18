# AllegroForthKit

A portable framework for programming games and other applications with [Allegro 5](http://liballeg.org/) in standard ANS Forth.

**Note:  AF-Kit now has a versioning system!  You must either provide a version when INCLUDEing kit/kit.f, or bypass it by pushing 0.**  

## Overview

This package brings up a hardware-accelerated graphics window so you can write games or other graphical programs in Forth.

Allegro is a portable low-level game development library. http://liballeg.org/

[Forth Foundation Library](http://soton.mpeforth.com/flag/ffl/index.html) is included for capabilities often required when working with modern libaries and file formats- features such as XML, Base64, MD5 etc.  XML DOM access and Base64 are automatically loaded to support some higher level features I plan on including in a framework based on this package, but this may change.

This is not a comprehensive game development library; it is a cleaned-up version of [Bubble](http://github.com/rogerlevy/bubble/) with fixed-point, Komodo-specific, and game-development-framework files removed and provisions for portability added.  

## Cross-platform Support

### Currently officially supported platforms:

- sfwin32 - [SwiftForth](https://www.forth.com/download/) (Win32)
- sflinux32 - [SwiftForth](https://www.forth.com/download/) (Linux)

### Details

/kitconfig.f specifies compile-time parameters, primarily the PLATFORM string, which should follow this general format:
    `<systemcode><oscode><archbits>`
    For example: sfwin32 = SwiftForth, Windows, 32-bit

/kit/platforms.f digests the PLATFORM string, creating other compile-time constants and loading platform-specific files such as FFL and Allegro via the platform configurations in plat/.  These files are the appropriate place to put "adapter" definitions or INCLUDEs to libraries that provide optional wordsets.

I've done my best to standardize the codebase.  It assumes ALL optional wordsets are available.  My recommendation for systems that don't support certain words is to either add them or fake them.  Contributions containing definitions or substitute for any missing non-standard words are greatly appreciated.

Contributions containing machine language or depending on any non-cross-platform libraries or system-specific words won't be accepted.

## Getting Started

Make copies of kitconfig.f_ and allegro5.cfg_, removing the underscores.

Set platform to the appropriate string.  See the Cross-platform Support section.

On Linux, you will need to install Allegro and the addons.  As of this writing 5.2 is the latest version.
```
sudo apt-get install liballegro5.2:i386 \
liballegro-acodec5.2:i386 \
liballegro-audio5.2:i386 \
liballegro-dialog5.2:i386 \
liballegro-image5.2:i386 \
liballegro-physfs5.2:i386 \
liballegro-ttf5.2:i386 \
liballegro-video5.2:i386 
```

### SwiftForth
[SwiftForth](https://www.forth.com/download/) is available from [FORTH Inc](http://www.forth.com).  The trial is fully functional apart from lacking source code.

From the SwiftForth prompt, change the current path to the root of your project (if needed) and "0 INCLUDE kit/kit.f" and type OK for a simple demonstration.

A fancier demonstration is forthcoming.

## Audio

When ALLEGRO_AUDIO is defined, audio-allegro.f will be loaded, which reserves 32 samples for playing samples with play_sample, and a default mixer and voice.  

## Graphics

Some essential tools are included in kit/gfx.f

## Other utilities

These files are included as part of the foundation:

- kit/ans/files.f - tools for more conveniently working with files
- kit/ans/strops.f - tools for constructing strings and working with zero-terminated strings
- kit/ans/roger.f - miscellaneous useful primitives

## The Piston (main loop) - kit/piston.f

This is a standard main loop which you're encouraged to use.

To enter the main loop type OK.  A default program defined in display.f will run.  Stop the loop by pressing CTRL+F12.

The piston has 3 phases.  The event handling phase, the "step" phase, and the display phase.  3 words are used to tell the loop what to do during these phases.  These words have a syntax similar to DOES>.  SHOW> owes its lineage to ColorForth.

- SHOW> changes the display.
- STEP> changes the logic.
- GO> changes your event handler and clears the step assignment.  use the words ETYPE and EVT to process Allegro events here.

## Roadmap

- [ ] In-game terminal
- [x] Add SwiftForth/Linux support
- [ ] Add portable directory walker utility
- [ ] Add or create official AF-Kit public domain 32-bit Intel ANS Forth and add support for it to bindings etc

## Links and Resources

- [Forth Programming 21st Century on Facebook](https://www.facebook.com/groups/PROGRAMMINGFORTH/) - The current active and growing forum on the web for modern desktop Forth programming (as opposed to on embedded or classic computers.)  Ask questions about Forth or AllegroForthKit and get quick answers!
- [Allegro 5.2.3 Documentation](http://liballeg.org/a5docs/5.2.3/)
- [Allegro 5.0 Documentation on allegro.cc](https://www.allegro.cc/manual/5/) - Integration with the forums. Will likely be out-of-date in places
- [Allegro.cc forum](https://www.allegro.cc/forums) - A very helpful and fairly active community.  And gladly, language-agnostic.
- [The DPANS94 Forth Standard](http://dl.forth.com/sitedocs/dpans94.pdf)
