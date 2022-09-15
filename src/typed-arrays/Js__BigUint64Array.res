type element = Js__NumericType.biguint64
type t

module Constants = {
  @val external bytesPerElement: int = "BigUint64Array.BYTES_PER_ELEMENT"
}

@new external fromBuffer: Js__ArrayBuffer.t => t = "BigUint64Array"
@new external fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t = "BigUint64Array"
@new
external fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t =
  "BigUint64Array"
@new external fromLength: int => t = "BigUint64Array"
@val external fromArray: array<element> => t = "BigUint64Array.from"
@val external fromArrayLike: Js.Array2.array_like<element> => t = "BigUint64Array.from"
@val external fromIterator: Js__Iterator.t<element> => t = "BigUint64Array.from"
/**
@parameter data An array-like or iterable object where each element is a boolean, bigint, or string.
@return A BigUint64Array that includes all of the values of data converted to BigUint64.
@throws TypeError if data isn't an array-like or iterable, or if any of the elements of
data are not a boolean, bigint, or string.
*/
@val
external fromConverted: 'a => t = "BigUint64Array.from"

include Js__TypedArray.TypedArray({
  type typedArray = t
  type element = element
})
