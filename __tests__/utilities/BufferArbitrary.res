open FastCheck.Arbitrary
open ReScriptJs.Js

let bufferArb = (~minSize, ~maxSize) => {
  TypedArrayArbitrary.uint8Array(~minSize, ~maxSize)->Derive.map(Uint8Array.buffer)
}
