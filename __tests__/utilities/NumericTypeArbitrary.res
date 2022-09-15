open ReScriptJs.Js
open NumericType
open FastCheck.Arbitrary

let rawInt8Arb = () => integerRange(-128, 127)
let int8Arb = () =>
  rawInt8Arb()->Derive.map(int8Exn)

let rawUint8Arb = () => integerRange(0, 255)
let uint8Arb = () =>
  rawUint8Arb()->Derive.map(uint8Exn)

let rawInt16Arb = () => integerRange(-32768, 32767)
let int16Arb = () =>
  rawInt16Arb()->Derive.map(int16Exn)

let int32Arb = () => integer()

let rawUint16Arb = () => integerRange(0, 65535)
let uint16Arb = () =>
  rawUint16Arb()->Derive.map(uint16Exn)

let rawUint32Arb = () => floatRange(0.0, 4294967295.0)->Derive.map(Js.Math.round)
let uint32Arb = () =>
  rawUint32Arb()->Derive.map(uint32Exn)

let rawUint64Arb = () =>
  Combinators.tuple2(rawUint32Arb(), rawUint32Arb())->Derive.map(((
    mostSignificant,
    leastSignificant,
  )) => {
    open BigInt
    fromFloat(mostSignificant)->BigInt.lsl(fromInt(32))->add(fromFloat(leastSignificant))
  })
let uint64Arb = () =>
  rawUint64Arb()->Derive.map(biguint64Exn)

let rawInt64Arb = () =>
  rawUint64Arb()->Derive.map(bits => {
    open BigInt
    let absMinInt64 = fromInt(1)->BigInt.lsl(fromInt(63)) // 2**63
    bits->sub(absMinInt64)
  })
let int64Arb = () =>
  rawInt64Arb()->Derive.map(bigint64Exn)

let float32Arb = () =>
  float_()->Derive.map(float32Exn)

let float64Arb = () => double()
