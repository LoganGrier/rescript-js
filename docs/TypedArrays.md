# Typed Arrays

## Deviations from JavaScript's TypedArray

To reduce defects in client code, we've split *from* into three functions: *fromArray*, *fromIterator*, and *fromConverted*.

fromArray and fromIterator take arrays and iterators with elements of the same type as the typed array. fromConverted takes any value, just like Javascript's from.

This allows clients to use fromArray or fromIterator and avoid implicit-conversion-related defects.
