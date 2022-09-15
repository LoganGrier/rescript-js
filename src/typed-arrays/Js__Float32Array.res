type element = Js__NumericType.float32
type t = Js__TypedArray.t<element>

module Constants = {
  @val external bytesPerElement: int = "Float32Array.BYTES_PER_ELEMENT"
}

@new external copy: t => t = "Float32Array"
@new external fromBuffer: Js__ArrayBuffer.t => t = "Float32Array"
@new external fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t = "Float32Array"
@new
external fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t =
  "Float32Array"
@new external fromLength: int => t = "Float32Array"
@val external fromArray: array<element> => t = "Float32Array.from"
@val external fromArrayLike: Js.Array2.array_like<element> => t = "Float32Array.from"
@val external fromIterator: Js__Iterator.t<element> => t = "Float32Array.from"
@val external fromConverted: 'a => t = "Float32Array.from"
