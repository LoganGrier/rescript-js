open FastCheck.Arbitrary
open ReScriptJs.Js
open NumericTypeArbitrary

let typedArrayArb = (elementArb, fromArray, ~minSize, ~maxSize) =>
  Combinators.arrayWithLength(elementArb(), minSize, maxSize)->Derive.map(fromArray)

let bigInt64Array = typedArrayArb(int64Arb, BigInt64Array.fromArray)
let bigUint64Array = typedArrayArb(uint64Arb, BigUint64Array.fromArray)
let float32Array = typedArrayArb(float32Arb, Float32Array.fromArray)
let float64Array = typedArrayArb(float64Arb, Float64Array.fromArray)
let int8Array = typedArrayArb(int8Arb, Int8Array.fromArray)
let int16Array = typedArrayArb(int16Arb, Int16Array.fromArray)
let int32Array = typedArrayArb(int32Arb, Int32Array.fromArray)
let uint8Array = typedArrayArb(uint8Arb, Uint8Array.fromArray)
let uint8ClampedArray = typedArrayArb(uint8Arb, Uint8ClampedArray.fromArray)
let uint16Array = typedArrayArb(uint16Arb, Uint16Array.fromArray)
let uint32Array = typedArrayArb(uint32Arb, Uint32Array.fromArray)
