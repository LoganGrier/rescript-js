type element = Js__NumericType.uint8
type t = Js__TypedArray.t<element>

module Constants = {
  @val external bytesPerElement: int = "Uint8ClampedArray.BYTES_PER_ELEMENT"
}

@new external copy: t => t = "Uint8ClampedArray"
@new external fromBuffer: Js__ArrayBuffer.t => t = "Uint8ClampedArray"
@new external fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t = "Uint8ClampedArray"
@new
external fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t =
  "Uint8ClampedArray"
@new external fromLength: int => t = "Uint8ClampedArray"
@val external fromArray: array<element> => t = "Uint8ClampedArray.from"
@val external fromArrayLike: Js.Array2.array_like<element> => t = "Uint8ClampedArray.from"
@val external fromIterator: Js__Iterator.t<element> => t = "Uint8ClampedArray.from"
@val external fromConverted: 'a => t = "Uint8ClampedArray.from"
