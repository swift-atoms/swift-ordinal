#if Tagged
import Cardinal
import Ordinal
import Tagged
import Testing

private struct StorageDomain: ~Copyable, ~Escapable {}
private enum ElementFailure: Swift.Error { case element }

@Suite struct `Valid storage values retain their meaning` {
    @Test(arguments: [UInt.zero, UInt(Int.max), UInt(Int.max) + 1, UInt.max])
    func `exact conversions and explicit bit patterns keep separate contracts`(raw: UInt) throws {
        let position = Ordinal(raw)
        let tagged = Tagged<StorageDomain, Ordinal>(position)
        if raw <= UInt(Int.max) {
            #expect(Int(exactly: position) == Int(raw))
            #expect(Int(exactly: tagged) == Int(raw))
            #expect(try Int(position) == Int(raw))
            #expect(try Int(tagged) == Int(raw))
        } else {
            #expect(Int(exactly: position) == nil)
            #expect(Int(exactly: tagged) == nil)
            #expect(throws: Ordinal.Error.overflow) { try Int(position) }
            #expect(throws: Ordinal.Error.overflow) { try Int(tagged) }
        }
        #expect(Int(bitPattern: position) == Int(bitPattern: raw))
        #expect(Int(bitPattern: tagged) == Int(bitPattern: raw))
    }

    @Test(arguments: [0 as UInt, 1, 3])
    func `array factories receive each position exactly once`(raw: UInt) {
        var visited: [UInt] = []
        let count = Tagged<StorageDomain, Cardinal>(Cardinal(raw))
        let values = Array(count: count) { position in
            visited.append(position.underlying.rawValue)
            return position.underlying.rawValue
        }
        #expect(visited == Array(0..<raw))
        #expect(values == visited)
    }

    @Test
    func `array factories preserve their precise error type`() {
        func build() throws(ElementFailure) -> [Int] {
            try Array(count: Tagged<StorageDomain, Cardinal>(Cardinal(2))) {
                (_: Tagged<StorageDomain, Ordinal>) throws(ElementFailure) -> Int in
                throw .element
            }
        }
        #expect(throws: ElementFailure.element) { try build() }
    }

    @Test
    func `arrays preserve the first and last valid positions`() {
        let first = Tagged<StorageDomain, Ordinal>(Ordinal.zero)
        let last = Tagged<StorageDomain, Ordinal>(Ordinal(2))
        let array = [10, 20, 30]
        #expect(array[first] == 10)
        #expect(array[last] == 30)

        var contiguous = ContiguousArray(array)
        contiguous[first] = 11
        contiguous[last] = 31
        #expect(contiguous[first] == 11)
        #expect(contiguous[last] == 31)

        var inline: InlineArray<3, Int> = [10, 20, 30]
        inline[first] = 12
        inline[last] = 32
        #expect(inline[first] == 12)
        #expect(inline[last] == 32)
    }

    @Test
    func `slice mutations preserve absolute collection indices`() {
        var slice = [10, 20, 30, 40][1...]
        slice.swapAt(Ordinal(1), Ordinal(3))
        #expect(slice.startIndex == 1)
        #expect(Array(slice) == [40, 30, 20])
        #expect(slice.remove(at: Ordinal(2)) == 30)
        slice.insert(99, at: Ordinal(2))
        #expect(Array(slice) == [40, 99, 20])
    }

    @Test
    func `zero counts construct empty buffers without storage`() {
        let count = Tagged<Int, Cardinal>(Cardinal(UInt.zero))
        let immutable = unsafe UnsafeBufferPointer<Int>(start: nil, count: count)
        let mutable = unsafe UnsafeMutableBufferPointer<Int>(start: nil, count: count)
        let immutableIsEmpty = immutable.isEmpty
        let mutableIsEmpty = mutable.isEmpty
        #expect(immutableIsEmpty)
        #expect(mutableIsEmpty)
    }

    @Test
    func `typed buffers and spans retain valid counts and mutations`() {
        var values = [10, 20]
        values.withUnsafeMutableBufferPointer { original in
            let pointer = original.baseAddress!
            let count = Tagged<Int, Cardinal>(Cardinal(2))
            let first = Tagged<Int, Ordinal>(Ordinal.zero)
            let last = Tagged<Int, Ordinal>(Ordinal(1))
            let immutable = unsafe UnsafeBufferPointer(start: UnsafePointer(pointer), count: count)
            #expect(immutable.count == 2)
            #expect(unsafe immutable[first] == 10)
            #expect(unsafe immutable[last] == 20)
            let mutable = unsafe UnsafeMutableBufferPointer(start: pointer, count: count)
            unsafe mutable[last] = 21
            #expect(unsafe mutable[last] == 21)

            let span = unsafe Span(_unsafeStart: UnsafePointer(pointer), count: count)
            #expect(span.count == 2)
            #expect(span[1] == 21)
            var mutableSpan = unsafe MutableSpan(_unsafeStart: pointer, count: count)
            mutableSpan[0] = 11
            let empty = unsafe Span(
                _unsafeStart: UnsafePointer(pointer),
                count: Tagged<Int, Cardinal>(Cardinal(UInt.zero))
            )
            let isEmpty = empty.isEmpty
            #expect(isEmpty)
        }
        #expect(values == [11, 21])
    }

    @Test
    func `output spans preserve initialized values while swapping`() {
        var values = [10, 20]
        values.withUnsafeMutableBufferPointer { buffer in
            var output = unsafe OutputSpan(buffer: buffer, initializedCount: 2)
            output.swapAt(Ordinal.zero, Ordinal(1))
            output.swapAt(Ordinal.zero, Ordinal.zero)
            let count = unsafe output.finalize(for: buffer)
            #expect(count == 2)
        }
        #expect(values == [20, 10])
    }

    @Test
    func `raw pointer positions retain forward byte offsets`() {
        var bytes: [UInt8] = [10, 20]
        bytes.withUnsafeMutableBytes { buffer in
            let mutable = buffer.baseAddress!
            let immutable = UnsafeRawPointer(mutable)
            let position = Tagged<StorageDomain, Ordinal>(Ordinal(1))
            #expect(unsafe mutable.distance(to: mutable.advanced(by: position)) == 1)
            #expect(unsafe immutable.distance(to: immutable.advanced(by: position)) == 1)
            #expect(unsafe mutable.load(fromByteOffset: position, as: UInt8.self) == 20)
            #expect(unsafe immutable.load(fromByteOffset: position, as: UInt8.self) == 20)
            unsafe mutable.storeBytes(of: UInt8(21), toByteOffset: position, as: UInt8.self)
        }
        #expect(bytes == [10, 21])
    }
}

#endif
