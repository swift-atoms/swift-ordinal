import Ordinal
import Ordinal_Standard_Library_Integration
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
}
