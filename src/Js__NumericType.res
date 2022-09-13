open ConstrainedType

module UInt8 = Constraint.MakeU({
  type t = int
  let isSatisfied = (. value) => 0 <= value && value <= 255
})
module Int8 = Constraint.MakeU({
  type t = int
  let isSatisfied = (. value) => -128 <= value && value <= 127
})
module UInt16 = Constraint.MakeU({
  type t = int
  let isSatisfied = (. value) => 0 <= value && value <= 65535
})
module Int16 = Constraint.MakeU({
  type t = int
  let isSatisfied = (. value) => -32768 <= value && value <= 32767
})
module UInt32 = Constraint.MakeU({
  // We use a float instead of an int since a uint32 can hold
  // any value between 0 and 4,294,967,295. While int can only hold values
  // between -2,147,483,648 and 2,147,483,647.
  type t = float
  let isInt = (. value) => Js.Math.round(value) == value
  let isSatisfied = (. value) => 0.0 <= value && value <= 4294967295.0 && isInt(. value)
})
module UInt64 = Constraint.MakeU({
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
