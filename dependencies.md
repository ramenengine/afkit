# Dependencies

## Allegro5

Select bindings are provided, written in SwiftForth syntax.

Doubles are expressed as 2 parameters.

## zlib

Provides bindings for just compress\(\) and uncompress\(\) and utility functions.

```text
: decompress  ( src #len dest #len -- #outputlen )
```

Given a source address range and a destination range, attempt to decompress the source data. Aborts if there's an error.

