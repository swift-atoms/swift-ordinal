import Difference
import Ordinal
import Tagged
import Testing

extension Ordinal {
    @Suite
    struct `UnsafePointer Subscript` {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
        @Suite(.serialized) struct Performance {}
    }
}

extension Ordinal.`UnsafePointer Subscript`.Unit {

    @Test
    func `get via ordinal`() {
        let values: [Int] = [10, 20, 30]
        values.withUnsafeBufferPointer { buf in
            let ptr = buf.baseAddress!
            let val = unsafe ptr[Ordinal(1)]
            #expect(val == 20)
        }
    }

    @Test
    func `get via tagged ordinal`() {
        struct Slot: ~Copyable {}
        let values: [Int] = [10, 20, 30]
        values.withUnsafeBufferPointer { buf in
            let ptr = buf.baseAddress!
            let idx = Tagged::Tagged<Slot, Ordinal>(Ordinal(2))
            let val = unsafe ptr[idx]
            #expect(val == 30)
        }
    }

    @Test
    func `typed pointer arithmetic uses difference offset`() {
        let values: [Int] = [10, 20, 30]
        values.withUnsafeBufferPointer { buffer in
            let start = buffer.baseAddress!
            let offset = Tagged<Int, Ordinal>.Offset(_unchecked: Difference(2))
            let end = unsafe start + offset
            let distance: Tagged<Int, Ordinal>.Offset = unsafe end - start

            #expect(unsafe end.pointee == 30)
            #expect(distance == offset)
            #expect(unsafe (end - offset).pointee == 10)
        }
    }
}
