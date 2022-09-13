open Jest
open FastCheck
open Expect
open Property.SyncUnit
open Arbitrary
open ReScriptJs.Js
open DataView
open DataViewArbitrary
open BufferArbitrary
open NumericTypeArbitrary

let getFetchesSet = (
  ~testName: string="Get fetches set",
  get: (DataView.t, int, ~littleEndian: bool=?, unit) => 'v,
  set: (DataView.t, int, 'v, ~littleEndian: bool=?, unit) => unit,
  valueArb: arbitrary<'v>,
  valueBitSize: int,
) => {
  let valueByteSize = valueBitSize / 8
  let maxDataviewSize = 1000
  test(testName, () => {
    assert_(
      property1(
        dataviewArb(~minSize=valueByteSize, ~maxSize=maxDataviewSize)->Derive.chain(
          dataview => {
            let setIndexArb = integerRange(0, dataview->byteLength - valueByteSize)
            Combinators.tuple4(
              Combinators.constant(dataview),
              setIndexArb,
              valueArb,
              Combinators.option(boolean()),
            )
          },
        ),
        ((dataview, setIndex, value, littleEndian)) => {
          switch littleEndian {
          | Some(littleEndian) => {
              set(dataview, setIndex, value, ~littleEndian, ())
              let getValue = get(dataview, setIndex, ~littleEndian, ())
              expect(getValue)->toEqual(value)->affirm
            }

          | None => {
              set(dataview, setIndex, value, ())
              let getValue = get(dataview, setIndex, ())
              expect(getValue)->toEqual(value)->affirm
            }
          }
        },
      ),
    )
    pass
  })
}

/**
Identical to getFetchesSet, but get and set don't take a littleEndian parameter, and 
valueBitSize is implicitley 8
*/
let getFetchesSet8Bit = (
  ~testName: string="Get fetches set",
  get: (DataView.t, int) => 'v,
  set: (DataView.t, int, 'v) => unit,
  valueArb: arbitrary<'v>,
) => {
  let valueByteSize = 1
  let maxDataviewSize = 1000
  test(testName, () => {
    assert_(
      property1(
        dataviewArb(~minSize=valueByteSize, ~maxSize=maxDataviewSize)->Derive.chain(
          dataview => {
            let setIndexArb = integerRange(0, dataview->byteLength - valueByteSize)
            Combinators.tuple3(Combinators.constant(dataview), setIndexArb, valueArb)
          },
        ),
        ((dataview, setIndex, value)) => {
          set(dataview, setIndex, value)
          let getValue = get(dataview, setIndex)
          expect(getValue)->toEqual(value)->affirm
        },
      ),
    )
    pass
  })
}

describe("fromBuffer", () => {
  test("Doesn't throw", () => {
    let buffer = ArrayBuffer.make(6)
    let dataview = fromBuffer(buffer)
    dataview->ignore
    pass
  })
})
describe("fromBufferToEnd", () => {
  test("Doesn't throw", () => {
    let buffer = ArrayBuffer.make(6)
    let dataview = fromBufferToEnd(buffer, ~byteOffset=3)
    dataview->ignore
    pass
  })
})
describe("fromBufferWithRange", () => {
  test("Doesn't throw", () => {
    let buffer = ArrayBuffer.make(6)
    let dataview = fromBufferWithRange(buffer, ~byteOffset=3, ~length=2)
    dataview->ignore
    pass
  })
})
describe("buffer", () => {
  test("Inverts fromBuffer", () => {
    let maxBufferSize = 1000
    assert_(
      property1(
        bufferArb(~minSize=0, ~maxSize=maxBufferSize),
        inputBuffer => {
          let dataView = fromBuffer(inputBuffer)
          let outputBuffer = dataView->buffer
          expect(outputBuffer)->toBe(inputBuffer)->affirm
        },
      ),
    )
    pass
  })
})
describe("byteLength", () => {
  testAll("Result is equals the dataview length", list{(12, 4, 2), (12, 0, 0), (12, 0, 12)}, ((
    bufferLength,
    byteOffset,
    length,
  )) => {
    let inputBuffer = ArrayBuffer.make(bufferLength)
    let dataView = fromBufferWithRange(inputBuffer, ~byteOffset, ~length)
    let actualLength = dataView->byteLength
    expect(actualLength)->toBe(length)
  })
})
describe("byteOffset", () => {
  testAll(
    "Result is the byte offset used to create the data view",
    list{(12, 4, 2), (12, 0, 0), (12, 0, 12)},
    ((bufferLength, byteOffset, length)) => {
      let inputBuffer = ArrayBuffer.make(bufferLength)
      let dataView = fromBufferWithRange(inputBuffer, ~byteOffset, ~length)
      let actualByteOffset = dataView->DataView.byteOffset
      expect(actualByteOffset)->toBe(byteOffset)
    },
  )
})

describe("Accessors", () => {
  describe("getInt8Raw and setInt8Truncated", () => {
    getFetchesSet8Bit(getInt8Raw, setInt8Truncated, rawInt8Arb())
  })
  describe("getInt8 and setInt8", () => {
    getFetchesSet8Bit(getInt8, setInt8, int8Arb())
  })

  describe("getUint8Raw and setUint8Truncated", () => {
    getFetchesSet8Bit(getUint8Raw, setUint8Truncated, rawUInt8Arb())
  })
  describe("getUint8 and setUint8", () => {
    getFetchesSet8Bit(getUint8, setUint8, uInt8Arb())
  })

  describe("getInt16Raw and setInt16Truncated", () => {
    getFetchesSet(getInt16Raw, setInt16Truncated, rawInt16Arb(), 16)
  })
  describe("getInt16 and setInt16", () => {
    getFetchesSet(getInt16, setInt16, int16Arb(), 16)
  })

  describe("getUint16Raw and setUint16Truncated", () => {
    getFetchesSet(getUint16Raw, setUint16Truncated, rawUInt16Arb(), 16)
  })
  describe("getUint16 and setUint16", () => {
    getFetchesSet(getUint16, setUint16, uInt16Arb(), 16)
  })

  describe("getInt32 and setInt32", () => {
    getFetchesSet(getInt32, setInt32, integer(), 32)
  })

  describe("getUint32Raw and setUint32Truncated", () => {
    getFetchesSet(getUint32Raw, setUint32Truncated, rawUInt32Arb(), 32)
  })
  describe("getUint32 and setUint32", () => {
    getFetchesSet(getUint32, setUint32, uInt32Arb(), 32)
  })

  describe("getInt64Raw and setBigInt64Truncated", () => {
    getFetchesSet(getBigInt64Raw, setBigInt64Truncated, rawInt64Arb(), 64)
  })
  describe("getInt64 and setBigInt64", () => {
    getFetchesSet(getBigInt64, setBigInt64, int64Arb(), 64)
  })

  describe("getUint64Raw and setBigUint64Truncated", () => {
    getFetchesSet(getBigUint64Raw, setBigUint64Truncated, rawUInt64Arb(), 64)
  })
  describe("getUint64 and setBigUint64", () => {
    getFetchesSet(getBigUint64, setBigUint64, uInt64Arb(), 64)
  })

  describe("getFloat32Raw and setFloat32Rounded", () => {
    getFetchesSet(getFloat32Raw, setFloat32Rounded, float_(), 32)
  })
  describe("getFloat32 and setFloat32", () => {
    getFetchesSet(getFloat32, setFloat32, float32Arb(), 32)
  })

  describe("getFloat64 and setFloat64", () => {
    getFetchesSet(getFloat64, setFloat64, double(), 64)
  })
})
