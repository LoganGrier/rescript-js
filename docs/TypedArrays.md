# Typed Arrays

## Deviations from JavaScript's TypedArray

To reduce defects in client code, we've made the following changes:

1. Split *from* into three functions: *fromArray*, *fromIterator*, and *fromConverted*.

    fromArray and fromIterator take arrays and iterators with elements of the same type as the typed array. fromConverted takes any value, just like Javascript's from.

    This allows clients to use fromArray or fromIterator and avoid implicit-conversion-related defects.

2. Removed the return value of functions that mutate their argument and return it. Specifically: copyWithin, fill, sort, and reverse.

    Function chaining isn't idiomatic in ReScript and would make the interface less intuitive.

## Implementing common TypedArray functions with a functor

Since Uint8Array and Uint8ClampedArray have identical element types, modeling typed arrays as generics that take a single element parameter would allow these types to be mutually assignable. The functor approach allows us to give each typed array its own distinct type and eliminate mutual assignability.
