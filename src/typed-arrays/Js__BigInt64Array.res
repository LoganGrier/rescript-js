type element = Js__NumericType.bigint64
type t = Js__TypedArray.t<element>

module Constants = {
  @val external bytesPerElement: int = "BigInt64Array.BYTES_PER_ELEMENT"
}

@new external copy: t => t = "BigInt64Array"
@new external fromBuffer: Js__ArrayBuffer.t => t = "BigInt64Array"
@new external fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t = "BigInt64Array"
@new
external fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t =
  "BigInt64Array"
@new external fromLength: int => t = "BigInt64Array"
@val external fromArray: array<element> => t = "BigInt64Array.from"
@val external fromArrayLike: Js.Array2.array_like<element> => t = "BigInt64Array.from"
@val external fromIterator: Js__Iterator.t<element> => t = "BigInt64Array.from"
/**
@parameter data An array-like or iterable object where each element is a boolean, bigint, or string.
@return A BigInt64Array that includes all of the values of data converted to BigInt64s. Bigint
values that are outside the range of bigint64 will be truncated and parsed as bigint64s using 
two's complement.
@throws TypeError if data isn't an array-like or iterable, or if any of the elements of
data are not a boolean, bigint, or string.
*/
@val
external fromConverted: 'a => t = "BigInt64Array.from"
