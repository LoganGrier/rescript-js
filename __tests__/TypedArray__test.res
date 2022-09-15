open Jest
open FastCheck
open Expect
open Property.SyncUnit
open Arbitrary
open ReScriptJs.Js
open NumericTypeArbitrary
open TypedArrayArbitrary

module type TestUtilities = {
  let typeName: string
  type element
  module Arbitrary: {
    let array: () => arbitrary<TypedArray.t<element>>  
    let element: () => arbitrary<element>
  }
}

module type TypedArray = {
  type element
  type t = TypedArray.t<element>
  let copy: t => t
  let fromBuffer: Js__ArrayBuffer.t => t
  let fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t
  let fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t
  let fromLength: int => t
  let fromArray: array<element> => t
  let fromIterator: Js__Iterator.t<element> => t
  let fromConverted: 'a => t
}

module Tests = (
  TypedArray: TypedArray, 
  TestUtilities: TestUtilities with type element = TypedArray.element
) => {
  describe(TestUtilities.typeName, () => {
    describe("copy", () => {
      test("Output equals input", () => {
        assertProperty1(
          TestUtilities.Arbitrary.array(),
          (input) => {
            let output = TypedArray.copy(input)
            expect(output)->toEqual(input)->affirm
          }
        )
        pass        
      })
    })
    describe("fromArray", () => {
      test("Result elements equal inputs", () => {
        assertProperty1(
          Combinators.array(TestUtilities.Arbitrary.element()),
          (input) => {
            let result = TypedArray.fromArray(input)
            let resultElements = result->ReScriptJs.Js.TypedArray.asArrayLike->Array.fromArrayLike
            expect(input)->toEqual(resultElements)->affirm
          }
        )
        pass
      })
    })
  })
}

module BigInt64Array = Tests(BigInt64Array, {
  let typeName = "BigInt64Array"
  type element = BigInt64Array.element
  module Arbitrary = {
    let array = () => bigInt64Array(~minSize=0, ~maxSize=100)
    let element = int64Arb
  }
})

module BigUint64Array = Tests(BigUint64Array, {
  let typeName = "BigUint64Array"
  type element = BigUint64Array.element
  module Arbitrary = {
    let array = () => bigUint64Array(~minSize=0, ~maxSize=100)
    let element = uint64Arb
  }
})

module Float32Array = Tests(Float32Array, {
  let typeName = "Float32Array"
  type element = Float32Array.element
  module Arbitrary = {
    let array = () => float32Array(~minSize=0, ~maxSize=100)
    let element = float32Arb
  }
})

module Float64Array = Tests(Float64Array, {
  let typeName = "Float64Array"
  type element = Float64Array.element
  module Arbitrary = {
    let array = () => float64Array(~minSize=0, ~maxSize=100)
    let element = float64Arb
  }
})

module Int8Array = Tests(Int8Array, {
  let typeName = "Int8Array"
  type element = Int8Array.element
  module Arbitrary = {
    let array = () => int8Array(~minSize=0, ~maxSize=100)
    let element = int8Arb
  }
})

module Int16Array = Tests(Int16Array, {
  let typeName = "Int16Array"
  type element = Int16Array.element
  module Arbitrary = {
    let array = () => int16Array(~minSize=0, ~maxSize=100)
    let element = int16Arb
  }
})

module Int32Array = Tests(Int32Array, {
  let typeName = "Int32Array"
  type element = Int32Array.element
  module Arbitrary = {
    let array = () => int32Array(~minSize=0, ~maxSize=100)
    let element = int32Arb
  }
})

module Uint8Array = Tests(Uint8Array, {
  let typeName = "Uint8Array"
  type element = Uint8Array.element
  module Arbitrary = {
    let array = () => uint8Array(~minSize=0, ~maxSize=100)
    let element = uint8Arb
  }
})

module Uint16Array = Tests(Uint16Array, {
  let typeName = "Uint16Array"
  type element = Uint16Array.element
  module Arbitrary = {
    let array = () => uint16Array(~minSize=0, ~maxSize=100)
    let element = uint16Arb
  }
})

module Uint32Array = Tests(Uint32Array, {
  let typeName = "Uint32Array"
  type element = Uint32Array.element
  module Arbitrary = {
    let array = () => uint32Array(~minSize=0, ~maxSize=100)
    let element = uint32Arb
  }
})