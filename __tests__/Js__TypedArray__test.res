open Jest
open FastCheck
open Expect
open Property.SyncUnit
open Arbitrary
open ReScriptJs.Js
open NumericTypeArbitrary
open TypedArrayArbitrary

describe("setTypedArray", () => {
  testAll(
    "Same type",
    list{
      (
        Uint8Array.fromConverted([1, 2, 3]),
        Uint8Array.fromConverted([4, 5, 6]),
        Uint8Array.fromConverted([4, 5, 6]),
      ),
      (
        Uint8Array.fromConverted([1, 2, 3]),
        Uint8Array.fromConverted([4, 5]),
        Uint8Array.fromConverted([4, 5, 3]),
      ),
      (
        Uint8Array.fromConverted([1, 2, 3]),
        Uint8Array.fromConverted([]),
        Uint8Array.fromConverted([1, 2, 3]),
      ),
    },
    ((arg1, arg2, expected)) => {
      Uint8Array.setTypedArray(arg1, arg2)
      expect(arg1)->toEqual(expected)
    },
  )
})
describe("setTypedArrayFrom", () => {
  testAll(
    "Same type",
    list{
      (
        Uint8Array.fromConverted([1, 2, 3]),
        Uint8Array.fromConverted([4, 5, 6]),
        0,
        Uint8Array.fromConverted([4, 5, 6]),
      ),
      (
        Uint8Array.fromConverted([1, 2, 3]),
        Uint8Array.fromConverted([4, 5]),
        0,
        Uint8Array.fromConverted([4, 5, 3]),
      ),
      (
        Uint8Array.fromConverted([1, 2, 3]),
        Uint8Array.fromConverted([]),
        0,
        Uint8Array.fromConverted([1, 2, 3]),
      ),
      (
        Uint8Array.fromConverted([1, 2, 3]),
        Uint8Array.fromConverted([4, 5]),
        1,
        Uint8Array.fromConverted([1, 4, 5]),
      ),
    },
    ((arg1, arg2, from, expected)) => {
      Uint8Array.setTypedArrayFrom(arg1, arg2, ~from)
      expect(arg1)->toEqual(expected)
    },
  )
})

module type TestUtilities = {
  let typeName: string
  type typedArray
  type element
  module Arbitrary: {
    let array: unit => arbitrary<typedArray>
    let element: unit => arbitrary<element>
  }
}

module type TypedArray = {
  type element
  type t
  let copy: t => t
  let fromBuffer: Js__ArrayBuffer.t => t
  let fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t
  let fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t
  let fromLength: int => t
  let fromArray: array<element> => t
  let fromIterator: Js__Iterator.t<element> => t
  let fromConverted: 'a => t
  let asArrayLike: t => Js.Array2.array_like<element>
}

module Tests = (
  TypedArray: TypedArray,
  TestUtilities: TestUtilities with type element = TypedArray.element and type typedArray = TypedArray.t,
) => {
  describe(TestUtilities.typeName, () => {
    describe("copy", () => {
      test(
        "Output equals input",
        () => {
          assertProperty1(
            TestUtilities.Arbitrary.array(),
            input => {
              let output = TypedArray.copy(input)
              expect(output)->toEqual(input)->affirm
            },
          )
          pass
        },
      )
    })
    describe("fromArray", () => {
      test(
        "Result elements equal inputs",
        () => {
          assertProperty1(
            Combinators.array(TestUtilities.Arbitrary.element()),
            input => {
              let result = TypedArray.fromArray(input)
              let resultElements = result->TypedArray.asArrayLike->Array.fromArrayLike
              expect(input)->toEqual(resultElements)->affirm
            },
          )
          pass
        },
      )
    })
  })
}

module BigInt64Array = Tests(
  BigInt64Array,
  {
    let typeName = "BigInt64Array"
    type typedArray = BigInt64Array.t
    type element = BigInt64Array.element
    module Arbitrary = {
      let array = () => bigInt64Array(~minSize=0, ~maxSize=100)
      let element = int64Arb
    }
  },
)

module BigUint64Array = Tests(
  BigUint64Array,
  {
    let typeName = "BigUint64Array"
    type typedArray = BigUint64Array.t
    type element = BigUint64Array.element
    module Arbitrary = {
      let array = () => bigUint64Array(~minSize=0, ~maxSize=100)
      let element = uint64Arb
    }
  },
)

module Float32Array = Tests(
  Float32Array,
  {
    let typeName = "Float32Array"
    type typedArray = Float32Array.t
    type element = Float32Array.element
    module Arbitrary = {
      let array = () => float32Array(~minSize=0, ~maxSize=100)
      let element = float32Arb
    }
  },
)

module Float64Array = Tests(
  Float64Array,
  {
    let typeName = "Float64Array"
    type typedArray = Float64Array.t
    type element = Float64Array.element
    module Arbitrary = {
      let array = () => float64Array(~minSize=0, ~maxSize=100)
      let element = float64Arb
    }
  },
)

module Int8Array = Tests(
  Int8Array,
  {
    let typeName = "Int8Array"
    type typedArray = Int8Array.t
    type element = Int8Array.element
    module Arbitrary = {
      let array = () => int8Array(~minSize=0, ~maxSize=100)
      let element = int8Arb
    }
  },
)

module Int16Array = Tests(
  Int16Array,
  {
    let typeName = "Int16Array"
    type typedArray = Int16Array.t
    type element = Int16Array.element
    module Arbitrary = {
      let array = () => int16Array(~minSize=0, ~maxSize=100)
      let element = int16Arb
    }
  },
)

module Int32Array = Tests(
  Int32Array,
  {
    let typeName = "Int32Array"
    type typedArray = Int32Array.t
    type element = Int32Array.element
    module Arbitrary = {
      let array = () => int32Array(~minSize=0, ~maxSize=100)
      let element = int32Arb
    }
  },
)

module Uint8Array = Tests(
  Uint8Array,
  {
    let typeName = "Uint8Array"
    type typedArray = Uint8Array.t
    type element = Uint8Array.element
    module Arbitrary = {
      let array = () => uint8Array(~minSize=0, ~maxSize=100)
      let element = uint8Arb
    }
  },
)

module Uint8ClampedArray = Tests(
  Uint8ClampedArray,
  {
    let typeName = "Uint8ClampedArray"
    type typedArray = Uint8ClampedArray.t
    type element = Uint8ClampedArray.element
    module Arbitrary = {
      let array = () => uint8ClampedArray(~minSize=0, ~maxSize=100)
      let element = uint8Arb
    }
  },
)

module Uint16Array = Tests(
  Uint16Array,
  {
    let typeName = "Uint16Array"
    type typedArray = Uint16Array.t
    type element = Uint16Array.element
    module Arbitrary = {
      let array = () => uint16Array(~minSize=0, ~maxSize=100)
      let element = uint16Arb
    }
  },
)

module Uint32Array = Tests(
  Uint32Array,
  {
    let typeName = "Uint32Array"
    type typedArray = Uint32Array.t
    type element = Uint32Array.element
    module Arbitrary = {
      let array = () => uint32Array(~minSize=0, ~maxSize=100)
      let element = uint32Arb
    }
  },
)
