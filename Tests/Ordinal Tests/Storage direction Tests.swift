import Ordinal
import Tagged
import Testing

@Suite(.serialized, .timeLimit(.minutes(1)))
struct `Ordinal storage positions cannot reverse direction` {
    @Test
    func `plain pointer positions cannot read backwards`() async {
        await #expect(processExitsWith: .failure) {
            let values = [10, 20]
            values.withUnsafeBufferPointer { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                precondition(unsafe second[Ordinal(UInt.max)] == 10)
            }
        }
    }

    @Test
    func `other domain pointer positions retain exact conversion`() async {
        await #expect(processExitsWith: .failure) {
            let values = [10, 20]
            values.withUnsafeBufferPointer { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                let position = Tagged<OtherDomain, Ordinal>(Ordinal(UInt.max))
                precondition(unsafe second[position] == 10)
            }
        }
    }

    @Test
    func `mutable pointer positions cannot read backwards`() async {
        await #expect(processExitsWith: .failure) {
            var values = [10, 20]
            values.withUnsafeMutableBufferPointer { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                precondition(unsafe second[Ordinal(UInt.max)] == 10)
            }
        }
    }

    @Test
    func `mutable pointer positions cannot write backwards`() async {
        await #expect(processExitsWith: .failure) {
            var values = [10, 20]
            values.withUnsafeMutableBufferPointer { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                unsafe second[Ordinal(UInt.max)] = 99
            }
        }
    }

    @Test
    func `raw pointer advancement cannot reverse direction`() async {
        await #expect(processExitsWith: .failure) {
            let values: [UInt8] = [10, 20]
            values.withUnsafeBytes { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                let result = unsafe second.advanced(by: Ordinal(UInt.max))
                precondition(unsafe second.distance(to: result) == -1)
            }
        }
    }

    @Test
    func `mutable raw pointer advancement cannot reverse direction`() async {
        await #expect(processExitsWith: .failure) {
            var values: [UInt8] = [10, 20]
            values.withUnsafeMutableBytes { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                let result = unsafe second.advanced(by: Ordinal(UInt.max))
                precondition(unsafe second.distance(to: result) == -1)
            }
        }
    }

    @Test
    func `raw byte loads cannot read backwards`() async {
        await #expect(processExitsWith: .failure) {
            let values: [UInt8] = [10, 20]
            values.withUnsafeBytes { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                precondition(unsafe second.load(fromByteOffset: Ordinal(UInt.max), as: UInt8.self) == 10)
            }
        }
    }

    @Test
    func `mutable raw byte loads cannot read backwards`() async {
        await #expect(processExitsWith: .failure) {
            var values: [UInt8] = [10, 20]
            values.withUnsafeMutableBytes { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                precondition(unsafe second.load(fromByteOffset: Ordinal(UInt.max), as: UInt8.self) == 10)
            }
        }
    }

    @Test
    func `raw byte stores cannot write backwards`() async {
        await #expect(processExitsWith: .failure) {
            var values: [UInt8] = [10, 20]
            values.withUnsafeMutableBytes { buffer in
                let second = unsafe buffer.baseAddress!.advanced(by: 1)
                unsafe second.storeBytes(of: UInt8(99), toByteOffset: Ordinal(UInt.max), as: UInt8.self)
            }
        }
    }

    @Test
    func `collection swaps cannot reinterpret a positive position`() async {
        await #expect(processExitsWith: .failure) {
            var values = SignedIndices()
            values.swapAt(Ordinal(UInt.max), Ordinal.zero)
        }
    }

    @Test
    func `collection removal cannot reinterpret a positive position`() async {
        await #expect(processExitsWith: .failure) {
            var values = SignedIndices()
            _ = values.remove(at: Ordinal(UInt.max))
        }
    }

    @Test
    func `collection insertion cannot reinterpret a positive position`() async {
        await #expect(processExitsWith: .failure) {
            var values = SignedIndices()
            values.insert(99, at: Ordinal(UInt.max))
        }
    }

}

private struct OtherDomain: ~Copyable, ~Escapable {}

private struct SignedIndices: MutableCollection, RangeReplaceableCollection {
    var values = [10, 20]
    var startIndex: Int { -1 }
    var endIndex: Int { values.count - 1 }
    func index(after i: Int) -> Int { i + 1 }
    subscript(i: Int) -> Int {
        get { values[i + 1] }
        set { values[i + 1] = newValue }
    }
    mutating func replaceSubrange<C: Collection>(
        _ subrange: Range<Int>, with newElements: C
    ) where C.Element == Int {
        values.replaceSubrange(
            (subrange.lowerBound + 1)..<(subrange.upperBound + 1),
            with: newElements
        )
    }
}

