open Js__NumericType

type t

@new external fromBuffer: Js__ArrayBuffer.t => t = "DataView"
@new external fromBufferToEnd: (Js__ArrayBuffer.t, ~byteOffset: int) => t = "DataView"
@new
external fromBufferWithRange: (Js__ArrayBuffer.t, ~byteOffset: int, ~length: int) => t = "DataView"

@get external buffer: t => Js__ArrayBuffer.t = "buffer"
@get external byteLength: t => int = "byteLength"
@get external byteOffset: t => int = "byteOffset"

@send external getInt8Raw: (t, int) => int = "getInt8"
@send external getInt8: (t, int) => int8 = "getInt8"

@send external getUint8Raw: (t, int) => int = "getUint8"
@send external getUint8: (t, int) => uint8 = "getUint8"

@send external getInt16Raw: (t, int, ~littleEndian: bool=?, unit) => int = "getInt16"
@send
external getInt16: (t, int, ~littleEndian: bool=?, unit) => int16 =
  "getInt16"

@send external getUint16Raw: (t, int, ~littleEndian: bool=?, unit) => int = "getUint16"
@send
external getUint16: (t, int, ~littleEndian: bool=?, unit) => uint16 =
  "getUint16"

// No getInt32Raw since all valid int values are valid int32 values
@send external getInt32: (t, int, ~littleEndian: bool=?, unit) => int = "getInt32"

/**
@return A float representing the given range.

We return a float instead of an int since a uint32 can hold 
any value between 0 and 4,294,967,295. While int can only hold values
between -2,147,483,648 and 2,147,483,647.
*/
@send
external getUint32Raw: (t, int, ~littleEndian: bool=?, unit) => float = "getUint32"
@send
external getUint32: (t, int, ~littleEndian: bool=?, unit) => uint32 =
  "getUint32"

@send external getFloat32Raw: (t, int, ~littleEndian: bool=?, unit) => float = "getFloat32"
@send
external getFloat32: (t, int, ~littleEndian: bool=?, unit) => float32 =
  "getFloat32"

// No getFloat64Raw since all valid float values are valid Float64 values
@send external getFloat64: (t, int, ~littleEndian: bool=?, unit) => float = "getFloat64"

@send external getBigInt64Raw: (t, int, ~littleEndian: bool=?, unit) => Js__BigInt.t = "getBigInt64"
@send
external getBigInt64: (
  t,
  int,
  ~littleEndian: bool=?,
  unit,
) => bigint64 = "getBigInt64"

@send
external getBigUint64Raw: (t, int, ~littleEndian: bool=?, unit) => Js__BigInt.t = "getBigUint64"
@send
external getBigUint64: (
  t,
  int,
  ~littleEndian: bool=?,
  unit,
) => biguint64 = "getBigUint64"

@send external setInt8Truncated: (t, int, int) => unit = "setInt8"
@send external setInt8: (t, int, int8) => unit = "setInt8"

@send external setUint8Truncated: (t, int, int) => unit = "setUint8"
@send external setUint8: (t, int, uint8) => unit = "setUint8"

@send external setInt16Truncated: (t, int, int, ~littleEndian: bool=?, unit) => unit = "setInt16"
@send
external setInt16: (t, int, int16, ~littleEndian: bool=?, unit) => unit =
  "setInt16"

@send external setUint16Truncated: (t, int, int, ~littleEndian: bool=?, unit) => unit = "setUint16"
@send
external setUint16: (t, int, uint16, ~littleEndian: bool=?, unit) => unit =
  "setUint16"

// No setInt32Truncated since all valid int values are valid int32 values
@send external setInt32: (t, int, int, ~littleEndian: bool=?, unit) => unit = "setInt32"

/**
@param dataview
@param offset
@param value

We take a float value instead of of an int since a uint32 can hold 
any value between 0 and 4,294,967,295. While int can only hold values
between -2,147,483,648 and 2,147,483,647.
*/
@send
external setUint32Truncated: (t, int, float, ~littleEndian: bool=?, unit) => unit = "setUint32"
@send
external setUint32: (t, int, uint32, ~littleEndian: bool=?, unit) => unit =
  "setUint32"

@send
external setFloat32Rounded: (t, int, float, ~littleEndian: bool=?, unit) => unit = "setFloat32"
@send
external setFloat32: (
  t,
  int,
  float32,
  ~littleEndian: bool=?,
  unit,
) => unit = "setFloat32"

// No setFloat64Truncated since all valid float values are valid float64 values
@send external setFloat64: (t, int, float, ~littleEndian: bool=?, unit) => unit = "setFloat64"

@send
external setBigInt64Truncated: (t, int, Js__BigInt.t, ~littleEndian: bool=?, unit) => unit =
  "setBigInt64"
@send
external setBigInt64: (
  t,
  int,
  bigint64,
  ~littleEndian: bool=?,
  unit,
) => unit = "setBigInt64"

@send
external setBigUint64Truncated: (t, int, Js__BigInt.t, ~littleEndian: bool=?, unit) => unit =
  "setBigUint64"
@send
external setBigUint64: (
  t,
  int,
  biguint64,
  ~littleEndian: bool=?,
  unit,
) => unit = "setBigUint64"
