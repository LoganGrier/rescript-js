type element = Js__NumericType.uint32
type t = Js__TypedArray.t<element>

module Constants = {
  @val external bytesPerElement: int = "Uint32Array.BYTES_PER_ELEMENT"
}

@new external copy: t => t = "Uint32Array"
@new external fromBuffer: Js__ArrayBuffer.t => t = "Uint32Array"
@new external fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t = "Uint32Array"
@new
external fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t =
  "Uint32Array"
@new external fromLength: int => t = "Uint32Array"
@val external fromArray: array<element> => t = "Uint32Array.from"
@val external fromArrayLike: Js.Array2.array_like<element> => t = "Uint32Array.from"
@val external fromIterator: Js__Iterator.t<element> => t = "Uint32Array.from"
@val external fromConverted: 'a => t = "Uint32Array.from"
