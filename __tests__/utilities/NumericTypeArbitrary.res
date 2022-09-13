open ReScriptJs.Js
open NumericType
open FastCheck.Arbitrary

let rawInt8Arb = () => integerRange(-128, 127)
let int8Arb = () =>
  rawInt8Arb()->Derive.map(int8Exn)
let rawUInt8Arb = () => integerRange(0, 255)
let uInt8Arb = () =>
  rawUInt8Arb()->Derive.map(uint8Exn)
let rawInt16Arb = () => integerRange(-32768, 32767)
let int16Arb = () =>
  rawInt16Arb()->Derive.map(int16Exn)
let rawUInt16Arb = () => integerRange(0, 65535)
let uInt16Arb = () =>
  rawUInt16Arb()->Derive.map(uint16Exn)
let rawUInt32Arb = () => floatRange(0.0, 4294967295.0)->Derive.map(Js.Math.round)
let uInt32Arb = () =>
  rawUInt32Arb()->Derive.map(uint32Exn)
let rawUInt64Arb = () =>
  Combinators.tuple2(rawUInt32Arb(), rawUInt32Arb())->Derive.map(((
    mostSignificant,
    leastSignificant,
  )) => {
    open BigInt
    fromFloat(mostSignificant)->BigInt.lsl(fromInt(32))->add(fromFloat(leastSignificant))
  })
let uInt64Arb = () =>
  rawUInt64Arb()->Derive.map(biguint64Exn)
let rawInt64Arb = () =>
  rawUInt64Arb()->Derive.map(bits => {
    open BigInt
    let absMinInt64 = fromInt(1)->BigInt.lsl(fromInt(63)) // 2**63
    bits->sub(absMinInt64)
  })
let int64Arb = () =>
  rawInt64Arb()->Derive.map(bigint64Exn)
let float32Arb = () =>
  float_()->Derive.map(float32Exn)
