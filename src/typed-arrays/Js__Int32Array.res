type element = Js__NumericType.int32
type t = Js__TypedArray.t<element>

module Constants = {
  @val external bytesPerElement: int = "Int32Array.BYTES_PER_ELEMENT"
}

@new external copy: t => t = "Int32Array"
@new external fromBuffer: Js__ArrayBuffer.t => t = "Int32Array"
@new external fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t = "Int32Array"
@new
external fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t =
  "Int32Array"
@new external fromLength: int => t = "Int32Array"
@val external fromArray: array<element> => t = "Int32Array.from"
@val external fromArrayLike: Js.Array2.array_like<element> => t = "Int32Array.from"
@val external fromIterator: Js__Iterator.t<element> => t = "Int32Array.from"
@val external fromConverted: 'a => t = "Int32Array.from"
