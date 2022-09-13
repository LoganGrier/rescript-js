open FastCheck.Arbitrary
open ReScriptJs.Js

let dataviewArb = (~minSize, ~maxSize) => {
  BufferArbitrary.bufferArb(~minSize, ~maxSize)->Derive.map(DataView.fromBuffer)
}
