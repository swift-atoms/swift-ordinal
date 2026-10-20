import Ordinal
import Tagged
import Testing

extension Ordinal {
    @Suite
    struct `Mutable pointers access elements at typed ordinal positions` {
        @Suite struct `Mutable pointers preserve element access through bare and tagged ordinals` {}
        @Suite struct `No UnsafeMutablePointer ordinal subscript boundary cases are defined` {}
        @Suite struct `No UnsafeMutablePointer ordinal subscript integration cases are defined` {}
        @Suite(.serialized) struct `No UnsafeMutablePointer ordinal subscript performance cases are defined` {}
    }
}

extension Ordinal.`Mutable pointers access elements at typed ordinal positions`.`Mutable pointers preserve element access through bare and tagged ordinals` {

    @Test
    func `A mutable pointer reads the element at a bare ordinal position`() {
        var values: [Int] = [10, 20, 30]
        values.withUnsafeMutableBufferPointer { buf in
            let ptr = buf.baseAddress!
            let val = unsafe ptr[Ordinal(1)]
            #expect(val == 20)
        }
    }

    @Test
    func `A mutable pointer replaces the element at a bare ordinal position`() {
        var values: [Int] = [10, 20, 30]
        values.withUnsafeMutableBufferPointer { buf in
            let ptr = buf.baseAddress!
            unsafe ptr[Ordinal(0)] = 99
            #expect(unsafe ptr[0] == 99)
        }
    }

    @Test
    func `A mutable pointer reads the element at a tagged ordinal position`() {
        struct Slot: ~Copyable {}
        var values: [Int] = [10, 20, 30]
        values.withUnsafeMutableBufferPointer { buf in
            let ptr = buf.baseAddress!
            let idx = Tagged::Tagged<Slot, Ordinal>(Ordinal(2))
            let val = unsafe ptr[idx]
            #expect(val == 30)
        }
    }

    @Test
    func `A mutable pointer replaces the element at a tagged ordinal position`() {
        struct Slot: ~Copyable {}
        var values: [Int] = [10, 20, 30]
        values.withUnsafeMutableBufferPointer { buf in
            let ptr = buf.baseAddress!
            let idx = Tagged::Tagged<Slot, Ordinal>(Ordinal(1))
            unsafe ptr[idx] = 77
            #expect(unsafe ptr[1] == 77)
        }
    }
}
