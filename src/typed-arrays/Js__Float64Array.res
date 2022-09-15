type element = Js__NumericType.float64
type t = Js__TypedArray.t<element>

module Constants = {
  @val external bytesPerElement: int = "Float64Array.BYTES_PER_ELEMENT"
}

@new external copy: t => t = "Float64Array"
@new external fromBuffer: Js__ArrayBuffer.t => t = "Float64Array"
@new external fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t = "Float64Array"
@new
external fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t =
  "Float64Array"
@new external fromLength: int => t = "Float64Array"
@val external fromArray: array<element> => t = "Float64Array.from"
@val external fromIterator: Js__Iterator.t<element> => t = "Float64Array.from"
@val external fromConverted: 'a => t = "Float64Array.from"
