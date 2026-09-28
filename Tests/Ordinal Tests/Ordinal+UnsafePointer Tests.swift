import Difference
import Ordinal
import Tagged
import Testing

extension Ordinal {
    @Suite
    struct `Immutable pointers access elements at typed ordinal positions` {
        @Suite struct `Immutable pointers preserve element access through bare and tagged ordinals` {}
        @Suite struct `No UnsafePointer ordinal subscript boundary cases are defined` {}
        @Suite struct `No UnsafePointer ordinal subscript integration cases are defined` {}
        @Suite(.serialized) struct `No UnsafePointer ordinal subscript performance cases are defined` {}
    }
}

extension Ordinal.`Immutable pointers access elements at typed ordinal positions`.`Immutable pointers preserve element access through bare and tagged ordinals` {

    @Test
    func `An immutable pointer reads the element at a bare ordinal position`() {
        let values: [Int] = [10, 20, 30]
        values.withUnsafeBufferPointer { buf in
            let ptr = buf.baseAddress!
            let val = unsafe ptr[Ordinal(1)]
            #expect(val == 20)
        }
    }

    @Test
    func `An immutable pointer reads the element at a tagged ordinal position`() {
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

