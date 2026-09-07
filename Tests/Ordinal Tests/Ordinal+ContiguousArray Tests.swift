import Ordinal
import Ordinal_Standard_Library_Integration
import Tagged
import Testing

extension Ordinal {
    @Suite
    struct `ContiguousArray Subscript` {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
        @Suite(.serialized) struct Performance {}
    }
}

extension Ordinal.`ContiguousArray Subscript`.Unit {

    @Test
    func `get via ordinal`() {
        let arr = ContiguousArray([10, 20, 30])
        let val = arr[Ordinal(1)]
        #expect(val == 20)
    }

    @Test
    func `set via ordinal`() {
        var arr = ContiguousArray([10, 20, 30])
        arr[Ordinal(0)] = 99
        #expect(arr[0] == 99)
    }

    @Test
    func `get via tagged ordinal`() {
        struct Slot: ~Copyable {}
        let arr = ContiguousArray([10, 20, 30])
        let idx = Tagged::Tagged<Slot, Ordinal>(Ordinal(2))
        let val = arr[idx]
        #expect(val == 30)
    }

    @Test
    func `set via tagged ordinal`() {
        struct Slot: ~Copyable {}
        var arr = ContiguousArray([10, 20, 30])
        let idx = Tagged::Tagged<Slot, Ordinal>(Ordinal(1))
        arr[idx] = 77
        #expect(arr[1] == 77)
    }
}
