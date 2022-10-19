use "Buffer"
use "Print"

class Bitset
  let _bits: Buffer

  new create(bytes: USize = 1) =>
    _bits = Buffer(bytes)

  new fromBuffer(bits: Buffer) =>
    _bits = bits

  fun apply(bitIndex: USize, byteIndex: (USize | None) = None): Bool ? =>
    if bitIndex >= (_bits.size() * 8) then
      error
    end
    match byteIndex
    | None =>
      ((_bits((bitIndex / 8))? and (1 << (bitIndex % 8).u8())) != 0)
    | let byteIndex'': USize =>
      ((_bits(byteIndex'')? and (1 << bitIndex.u8())) != 0)
    end

  fun ref _allocate(n: USize) =>
    if n >= _bits.size() then
      while _bits.size() <= n do
        _bits.push(0)
      end
    end

  fun ref update(index: (USize | (USize, USize)), value: Bool): Bool ? =>
    match index
      | let index': USize =>
        let byteIndex: USize = index'/ 8
        let bitIndex: USize = index' % 8
        _allocate(byteIndex)
        _bits(byteIndex)? = _bits(byteIndex)?
        if value then
          let old = _bits(byteIndex)? = (_bits(byteIndex)? or (U8(1) << bitIndex.u8()))
          ((old and (1 << bitIndex.u8())) != 0)
        else
          let old = _bits(byteIndex)? = (_bits(byteIndex)? and (not (U8(1) << bitIndex.u8())))
          ((old and (1 << bitIndex.u8())) != 0)
        end
      | (let bitIndex: USize, let byteIndex: USize) =>
        _allocate(byteIndex)
        if value then
          let old = _bits(byteIndex)? = (_bits(byteIndex)? or (U8(1) << bitIndex.u8()))
          ((old and (1 << bitIndex.u8())) != 0)
        else
          let old = _bits(byteIndex)? = (_bits(byteIndex)? and (not (U8(1) << bitIndex.u8())))
          ((old and (1 << bitIndex.u8())) != 0)
        end
    end

  fun ref set(index: (USize | (USize, USize)), value: Bool) ? =>
    match index
      | let index': USize =>
        let byteIndex: USize = index'/ 8
        let bitIndex: USize = index' % 8
        _allocate(byteIndex)
        _bits(byteIndex)? = _bits(byteIndex)?
        if value then
          _bits(byteIndex)? = (_bits(byteIndex)? or (U8(1) << bitIndex.u8()))
        else
          _bits(byteIndex)? = (_bits(byteIndex)? and (not (U8(1) << bitIndex.u8())))
        end
      | (let bitIndex: USize, let byteIndex: USize) =>
        _allocate(byteIndex)
        if value then
          _bits(byteIndex)? = (_bits(byteIndex)? or (U8(1) << bitIndex.u8()))
        else
          _bits(byteIndex)? = (_bits(byteIndex)? and (not (U8(1) << bitIndex.u8())))
        end
    end

  fun box compare(that: box->Bitset): I8 ? =>
    _bits.compare(that._bits)?

  fun box eq(that: box->Bitset): Bool =>
    try
      compare(that)? == 0
    else
      false
    end

  fun box ne(that: box->Bitset): Bool =>
    not eq(that)

  fun box gt (that: box->Bitset): Bool =>
    try
      compare(that)? == 1
    else
      false
    end

  fun box ge (that: box->Bitset): Bool =>
    try
      let i: I8 = compare(that)?
      ((i == 0) or (i == 1))
    else
      false
    end

  fun box lt (that: box->Bitset): Bool =>
    try
      compare(that)? == -1
    else
      false
    end

  fun box le (that: box->Bitset): Bool =>
    try
      let i: I8 = compare(that)?
      ((i == 0) or (i == 1))
    else
      false
    end

  fun hash(): USize =>
    _bits.hash()

  fun hash64(): U64 =>
    _bits.hash64()

  fun box op_xor (that: box->Bitset): Bitset ref =>
    Bitset.fromBuffer( _bits xor that._bits)

  fun box op_and (that: box->Bitset): Bitset ref =>
    Bitset.fromBuffer(_bits and that._bits)

  fun box op_or (that: box->Bitset): Bitset ref =>
    Bitset.fromBuffer( _bits or that._bits)

  fun box op_not (): Bitset ref =>
    Bitset.fromBuffer(not _bits)

  fun box values() : ArrayValues[U8, this->Array[U8 val]]^ =>
    _bits.values()

  fun box size(): USize =>
    _bits.size()

  fun ref compact() =>
    _bits.compact()
