open ConstrainedType

module Constraint = {
  module Uint8 = Constraint.MakeU({
    type t = int
    let isSatisfied = (. value) => 0 <= value && value <= 255
  })
  module Int8 = Constraint.MakeU({
    type t = int
    let isSatisfied = (. value) => -128 <= value && value <= 127
  })
  module Uint16 = Constraint.MakeU({
    type t = int
    let isSatisfied = (. value) => 0 <= value && value <= 65535
  })
  module Int16 = Constraint.MakeU({
    type t = int
    let isSatisfied = (. value) => -32768 <= value && value <= 32767
  })
  module Uint32 = Constraint.MakeU({
    // We use a float instead of an int since a uint32 can hold
    // any value between 0 and 4,294,967,295. While int can only hold values
    // between -2,147,483,648 and 2,147,483,647.
    type t = float
    let isInt = (. value) => Js.Math.round(value) == value
    let isSatisfied = (. value) => 0.0 <= value && value <= 4294967295.0 && isInt(. value)
  })
  module Uint64 = Constraint.MakeU({
    type t = Js__BigInt.t
    let maxValue = Js__BigInt.fromString("18446744073709551615")
    let minValue = Js__BigInt.fromFloat(0.0)
    let isSatisfied = (. value) => minValue->Js__BigInt.le(value) && value->Js__BigInt.le(maxValue)
  })
  module Int64 = Constraint.MakeU({
    type t = Js__BigInt.t
    let maxValue = Js__BigInt.fromString("9223372036854775807")
    let minValue = Js__BigInt.fromString("-9223372036854775808")
    let isSatisfied = (. value) => minValue->Js__BigInt.le(value) && value->Js__BigInt.le(maxValue)
  })
  module Float32 = Constraint.MakeU({
    type t = float
    // Since NaN != NaN, we must check Js.Float.isNaN seperatley
    let isSatisfied = (. value) => Js.Math.fround(value) == value || Js.Float.isNaN(value)
  })
}

open Constraint

type uint8 = Value.t<int, Uint8.identity>
type int8 = Value.t<int, Int8.identity>
type uint16 = Value.t<int, Uint16.identity>
type int16 = Value.t<int, Int16.identity>
type uint32 = Value.t<float, Uint32.identity>
type int32 = int
// Rescript has a built-in int64 in the global namespace so we prefix our 64 bit
// integer names with"big" to avoid redefining int64
type biguint64 = Value.t<Js__BigInt.t, Uint64.identity>
type bigint64 = Value.t<Js__BigInt.t, Int64.identity>

type float32 = Value.t<float, Float32.identity>
type float64 = float

let uint8 = ConstrainedType.Value.make(~constraint_=module(Uint8))
let uint8Exn = ConstrainedType.Value.makeExn(~constraint_=module(Uint8))
let uint8Unsafe = ConstrainedType.Value.makeUnsafe(~constraint_=module(Uint8))

let int8 = ConstrainedType.Value.make(~constraint_=module(Int8))
let int8Exn = ConstrainedType.Value.makeExn(~constraint_=module(Int8))
let int8Unsafe = ConstrainedType.Value.makeUnsafe(~constraint_=module(Int8))

let uint16 = ConstrainedType.Value.make(~constraint_=module(Uint16))
let uint16Exn = ConstrainedType.Value.makeExn(~constraint_=module(Uint16))
let uint16Unsafe = ConstrainedType.Value.makeUnsafe(~constraint_=module(Uint16))

let int16 = ConstrainedType.Value.make(~constraint_=module(Int16))
let int16Exn = ConstrainedType.Value.makeExn(~constraint_=module(Int16))
let int16Unsafe = ConstrainedType.Value.makeUnsafe(~constraint_=module(Int16))

let uint32 = ConstrainedType.Value.make(~constraint_=module(Uint32))
let uint32Exn = ConstrainedType.Value.makeExn(~constraint_=module(Uint32))
let uint32Unsafe = ConstrainedType.Value.makeUnsafe(~constraint_=module(Uint32))

let biguint64 = ConstrainedType.Value.make(~constraint_=module(Uint64))
let biguint64Exn = ConstrainedType.Value.makeExn(~constraint_=module(Uint64))
let biguint64Unsafe = ConstrainedType.Value.makeUnsafe(~constraint_=module(Uint64))

let bigint64 = ConstrainedType.Value.make(~constraint_=module(Int64))
let bigint64Exn = ConstrainedType.Value.makeExn(~constraint_=module(Int64))
let bigint64Unsafe = ConstrainedType.Value.makeUnsafe(~constraint_=module(Int64))

let float32 = ConstrainedType.Value.make(~constraint_=module(Float32))
let float32Exn = ConstrainedType.Value.makeExn(~constraint_=module(Float32))
let float32Unsafe = ConstrainedType.Value.makeUnsafe(~constraint_=module(Float32))
