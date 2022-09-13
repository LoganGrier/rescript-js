open FastCheck.Arbitrary
open ReScriptJs.Js

let uint8ArrayArb = (~minSize, ~maxSize) =>
  Combinators.arrayWithLength(NumericTypeArbitrary.rawUInt8Arb(), minSize, maxSize)->Derive.map(
    Uint8Array.make,
  )
