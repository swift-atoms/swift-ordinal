import Ordinal
import Tagged
import Testing

extension Ordinal {
    @Suite
    struct `Contiguous arrays access elements at typed ordinal positions` {
        @Suite struct `Contiguous arrays preserve element access through bare and tagged ordinals` {}
        @Suite struct `No ContiguousArray ordinal subscript boundary cases are defined` {}
        @Suite struct `No ContiguousArray ordinal subscript integration cases are defined` {}
        @Suite(.serialized) struct `No ContiguousArray ordinal subscript performance cases are defined` {}
    }
}

extension Ordinal.`Contiguous arrays access elements at typed ordinal positions`.`Contiguous arrays preserve element access through bare and tagged ordinals` {

    @Test
    func `A contiguous array reads the element at a bare ordinal position`() {
        let arr = ContiguousArray([10, 20, 30])
        let val = arr[Ordinal(1)]
        #expect(val == 20)
    }

    @Test
    func `A contiguous array replaces the element at a bare ordinal position`() {
        var arr = ContiguousArray([10, 20, 30])
        arr[Ordinal(0)] = 99
        #expect(arr[0] == 99)
    }

    @Test
    func `A contiguous array reads the element at a tagged ordinal position`() {
        struct Slot: ~Copyable {}
        let arr = ContiguousArray([10, 20, 30])
        let idx = Tagged::Tagged<Slot, Ordinal>(Ordinal(2))
        let val = arr[idx]
        #expect(val == 30)
    }

    @Test
    func `A contiguous array replaces the element at a tagged ordinal position`() {
        struct Slot: ~Copyable {}
        var arr = ContiguousArray([10, 20, 30])
        let idx = Tagged::Tagged<Slot, Ordinal>(Ordinal(1))
        arr[idx] = 77
        #expect(arr[1] == 77)
    }
}
