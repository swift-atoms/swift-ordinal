import Difference
import Cardinal
import Ordinal
import Carrier
import Tagged
import struct Tagged.Tagged
import Testing

private enum Element {}

private typealias Position = Tagged<Element, Ordinal>
private typealias Offset = Tagged<Element, Difference>
private typealias Count = Tagged<Element, Cardinal>

private func position(_ value: UInt) -> Position {
    Position(Ordinal(value))
}

private func offset(_ value: Int) -> Offset {
    Offset(_unchecked: Difference(value))
}

private func count(_ value: UInt) -> Count {
    Count(Cardinal(value))
}

extension Difference {
    @Suite
    struct CarrierTests {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
    }
}

extension Difference.CarrierTests.Unit {

    @Test
    func `vector exposes its carrier value`() {
        let vector = Difference(3)
        #expect(vector.difference == Difference(3))
    }

    @Test
    func `tagged vector carrier constants preserve the domain`() {
        #expect(Int(exactly: Offset.zero.underlying) == 0)
        #expect(Int(exactly: Offset.one.underlying) == 1)
    }

    @Test
    func `tagged vector carrier arithmetic preserves the domain`() {
        var result = offset(5) + offset(3)
        #expect(Int(exactly: result.underlying) == 8)
        result -= offset(2)
        #expect(Int(exactly: result.underlying) == 6)
        #expect(Int(exactly: (-result).underlying) == -6)
    }

    @Test
    func `integer conversion accepts vector carriers`() {
        #expect(Int(exactly: Difference(-3)) == -3)
        #expect(Int(exactly: offset(7)) == 7)
    }

    @Test
    func `ordinal advances by positive and negative carriers`() throws(Ordinal.Error) {
        let advanced: Position = try position(5) + offset(3)
        let retreated: Position = try position(5) + offset(-3)
        #expect(advanced.ordinal.rawValue == 8)
        #expect(retreated.ordinal.rawValue == 2)
    }

    @Test
    func `vector carrier plus ordinal is commutative`() throws(Ordinal.Error) {
        let result: Position = try offset(3) + position(5)
        #expect(result.ordinal.rawValue == 8)
    }

    @Test
    func `ordinal subtracts a vector carrier`() throws(Ordinal.Error) {
        let result: Position = try position(5) - offset(3)
        #expect(result.ordinal.rawValue == 2)
    }

    @Test
    func `ordinal difference produces signed magnitudes`() {
        let forward: Offset = position(8) - position(3)
        let backward: Offset = position(3) - position(8)
        #expect(forward.underlying == Difference(5))
        #expect(backward.underlying == Difference(-5))
    }

    @Test
    func `compound ordinal arithmetic preserves its carrier`() throws(Ordinal.Error) {
        var value = position(5)
        try value += offset(3)
        try value -= offset(2)
        #expect(value.ordinal.rawValue == 6)
    }

    @Test
    func `vector and cardinal carriers compare within one domain`() {
        #expect(offset(-1) < count(0))
        #expect(offset(3) < count(5))
        #expect(count(5) > offset(3))
        #expect(count(3) <= offset(3))
    }
}

extension Difference.CarrierTests.`Edge Case` {

    @Test
    func `negative advance underflows`() {
        #expect(throws: Ordinal.Error.underflow) {
            let _: Position = try position(2) + offset(-5)
        }
    }

    @Test
    func `positive advance overflows`() {
        #expect(throws: Ordinal.Error.overflow) {
            let _: Position = try position(.max) + offset(1)
        }
    }

    @Test
    func `positive subtraction underflows`() {
        #expect(throws: Ordinal.Error.underflow) {
            let _: Position = try position(2) - offset(5)
        }
    }

    @Test
    func `negative subtraction overflows`() {
        #expect(throws: Ordinal.Error.overflow) {
            let _: Position = try position(.max) - offset(-1)
        }
    }

    @Test
    func `ordinal difference preserves UInt max and rejects only Int narrowing`() {
        let difference: Offset = position(.max) - position(0)
        #expect(difference.underlying.magnitude.value.rawValue == UInt.max)
        #expect(Int(exactly: difference) == nil)
    }

    @Test
    func `cardinal comparison handles the full unsigned range`() {
        #expect(offset(Int.max) < count(.max))
        #expect(count(.max) > offset(Int.max))
        #expect(offset(Int.min) < count(.max))
    }
}

extension Difference.CarrierTests.Integration {

    @Test
    func `collection indexing accepts vector carriers`() {
        let values = [10, 20, 30, 40]
        let index = values.index(values.startIndex, offsetBy: offset(2))
        #expect(values[index] == 30)
    }

    @Test
    func `limited collection indexing accepts vector carriers`() {
        let values = [10, 20, 30, 40]
        let limit = values.index(values.startIndex, offsetBy: 2)
        #expect(values.index(values.startIndex, offsetBy: offset(3), limitedBy: limit) == nil)
    }

    @Test
    func `collection index mutation accepts vector carriers`() {
        let values = [10, 20, 30, 40]
        var index = values.startIndex
        values.formIndex(&index, offsetBy: offset(3))
        #expect(values[index] == 40)
    }

    @Test
    func `raw pointer access accepts vector carriers`() {
        let stride = MemoryLayout<Int>.stride
        let pointer = UnsafeMutableRawPointer.allocate(
            byteCount: stride * 2,
            alignment: MemoryLayout<Int>.alignment
        )
        defer { unsafe pointer.deallocate() }

        let second = offset(stride)
        unsafe pointer.storeBytes(of: 10, toByteOffset: offset(0), as: Int.self)
        unsafe pointer.storeBytes(of: 20, toByteOffset: second, as: Int.self)
        #expect(unsafe pointer.load(fromByteOffset: second, as: Int.self) == 20)

        let advanced = unsafe pointer.advanced(by: second)
        #expect(unsafe advanced.load(as: Int.self) == 20)
    }
}

