open Jest
open Expect
open ReScriptJs.Js
open NumericType
open ConstrainedType

describe("UInt8", () => {
  testAll(
    "isSatisfied",
    list{(0, true), (1, true), (255, true), (42, true), (-1, false), (256, false)},
    ((value, expected)) => {
      expect(Constraint.isSatisfied(module(UInt8), value))->toBe(expected)
    },
  )
})
describe("Int8", () => {
  testAll(
    "isSatisfied",
    list{(0, true), (1, true), (42, true), (127, true), (128, false), (-128, true), (-129, false)},
    ((value, expected)) => {
      expect(Constraint.isSatisfied(module(Int8), value))->toBe(expected)
    },
  )
})
describe("UInt16", () => {
  testAll(
    "isSatisfied",
    list{(0, true), (1, true), (65535, true), (42, true), (-1, false), (65536, false)},
    ((value, expected)) => {
      expect(Constraint.isSatisfied(module(UInt16), value))->toBe(expected)
    },
  )
})
describe("Int16", () => {
  testAll(
    "isSatisfied",
    list{
      (0, true),
      (1, true),
      (42, true),
      (32767, true),
      (32768, false),
      (-32768, true),
      (-32769, false),
    },
    ((value, expected)) => {
      expect(Constraint.isSatisfied(module(Int16), value))->toBe(expected)
    },
  )
})
describe("UInt32", () => {
  testAll(
    "isSatisfied",
    list{
      (0.0, true),
      (1.0, true),
      (4294967295.0, true),
      (42.0, true),
      (-1.0, false),
      (4294967296.0, false),
      (4294967295.5, false),
      (4294967294.5, false),
      (0.5, false),
    },
    ((value, expected)) => {
      expect(Constraint.isSatisfied(module(UInt32), value))->toBe(expected)
    },
  )
})
describe("UInt64", () => {
  open Js__BigInt
  testAll(
    "isSatisfied",
    list{
      (fromString("0"), true),
      (fromString("1"), true),
      (fromString("18446744073709551615"), true),
      (fromString("42"), true),
      (fromString("-1"), false),
      (fromString("18446744073709551616"), false),
    },
    ((value, expected)) => {
      expect(Constraint.isSatisfied(module(UInt64), value))->toBe(expected)
    },
  )
})
describe("Int64", () => {
  open Js__BigInt
  testAll(
    "isSatisfied",
    list{
      (fromString("0"), true),
      (fromString("1"), true),
      (fromString("9223372036854775807"), true),
      (fromString("42"), true),
      (fromString("-1"), true),
      (fromString("9223372036854775808"), false),
      (fromString("-9223372036854775808"), true),
      (fromString("-9223372036854775809"), false),
    },
    ((value, expected)) => {
      expect(Constraint.isSatisfied(module(Int64), value))->toBe(expected)
    },
  )
})
describe("Float32", () => {
  testAll(
    "isSatisfied",
    list{
      (0.0, true),
      (1.0, true),
      (0.1, false), // Infininate repeating binary must have different float32 and float64 representations
      (-1.0, true),
      (-0.1, false), // Infininate repeating binary must have different float32 and float64 representations
      (0.5, true),
      (-0.5, true),
      (Js.Float._NaN, true),
      (Pervasives.infinity, true),
      (Pervasives.neg_infinity, true),
      (340282346638528859811704183484516925440.0, true), // Maximum finite float32
      (440282346638528859811704183484516925440.0, false),
      (-340282346638528859811704183484516925440.0, true), // Minimum finite float32
      (-440282346638528859811704183484516925440.0, false),
    },
    ((value, expected)) => {
      expect(Constraint.isSatisfied(module(Float32), value))->toBe(expected)
    },
  )
})
