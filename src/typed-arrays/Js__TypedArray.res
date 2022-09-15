module type Args = {
  type typedArray
  type element
}

module TypedArray = (Args: Args) => {
  open Args
  @get_index external get: (typedArray, int) => option<element> = ""
  @set_index external set: (typedArray, int, element) => unit = ""

  @get external buffer: typedArray => Js__ArrayBuffer.t = "buffer"
  @get external byteLength: typedArray => int = "byteLength"
  @get external byteOffset: typedArray => int = "byteOffset"

  @send external setArray: (typedArray, array<element>) => unit = "set"
  @send external setArrayFrom: (typedArray, array<element>, ~from: int) => unit = "set"

  @send external setTypedArray: (typedArray, typedArray) => unit = "set"
  @send external setTypedArrayFrom: (typedArray, typedArray, ~from: int) => unit = "set"

  @get external length: typedArray => int = "length"

  @send external copyAllWithin: (typedArray, ~target: int) => unit = "copyWithin"
  @send external copyWithinToEnd: (typedArray, ~target: int, ~start: int) => unit = "copyWithin"
  @send
  external copyWithin: (typedArray, ~target: int, ~start: int, ~end: int) => unit = "copyWithin"

  @send external fillAll: (typedArray, element) => unit = "fill"
  @send external fillToEnd: (typedArray, element, ~start: int) => unit = "fill"
  @send external fill: (typedArray, element, ~start: int, ~end: int) => unit = "fill"

  @send external reverse: typedArray => unit = "reverse"
  @send external sort: (typedArray, (element, element) => int) => unit = "sort"

  @send external includes: (typedArray, element) => bool = "includes"

  @send external indexOf: (typedArray, element) => int = "indexOf"
  @send external indexOfFrom: (typedArray, element, ~from: int) => int = "indexOf"

  @send external joinWith: (typedArray, string) => string = "join"

  @send external lastIndexOf: (typedArray, element) => int = "lastIndexOf"
  @send external lastIndexOfFrom: (typedArray, element, ~from: int) => int = "lastIndexOf"

  @send external slice: (typedArray, ~from: int, ~end: int) => typedArray = "slice"
  @send external sliceToEnd: (typedArray, ~from: int) => typedArray = "slice"
  @send external copy: typedArray => typedArray = "slice"

  @send external subarray: (typedArray, ~from: int, ~end: int) => typedArray = "subarray"
  @send external subarrayToEnd: (typedArray, ~from: int) => typedArray = "subarray"

  @send external toString: typedArray => string = "toString"
  @send external toLocaleString: typedArray => string = "toLocaleString"

  @send external every: (typedArray, element => bool) => bool = "every"
  @send external everyWithIndex: (typedArray, (element, int) => bool) => bool = "every"

  @send external filter: (typedArray, element => bool) => typedArray = "filter"
  @send external filterWithIndex: (typedArray, (element, int) => bool) => typedArray = "filter"

  @send external find: (typedArray, element => bool) => option<element> = "find"
  @send external findWithIndex: (typedArray, (element, int) => bool) => option<element> = "find"

  @send external findIndex: (typedArray, element => bool) => int = "findIndex"
  @send external findIndexWithIndex: (typedArray, (element, int) => bool) => int = "findIndex"

  @send external forEach: (typedArray, element => unit) => unit = "forEach"
  @send external forEachWithIndex: (typedArray, (element, int) => unit) => unit = "forEach"

  @send external map: (typedArray, element => element) => typedArray = "map"
  @send external mapWithIndex: (typedArray, (element, int) => element) => typedArray = "map"

  @send external reduce: (typedArray, ('acc, element) => 'acc, 'acc) => 'acc = "reduce"
  @send external reduceWithIndex: (typedArray, ('acc, element, int) => 'acc, 'acc) => 'acc = "reduce"

  @send external reduceRight: (typedArray, ('acc, element) => 'acc, 'acc) => 'acc = "reduceRight"
  @send external reduceRightWithIndex: (typedArray, ('acc, element, int) => 'acc, 'acc) => 'acc = "reduceRight"

  @send external some: (typedArray, element => bool) => bool = "some"
  @send external someWithIndex: (typedArray, (element, int) => bool) => bool = "some"

  external asArrayLike: typedArray => Js.Array2.array_like<element> = "%identity"
}
