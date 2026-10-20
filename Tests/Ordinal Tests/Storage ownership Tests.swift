import Cardinal
import Ordinal
import Tagged
import Testing

private final class Deaths {
    var ids: [Int] = []
}

private struct Token: ~Copyable {
    let id: Int
    let deaths: Deaths
    deinit { deaths.ids.append(id) }
}

private final class Object {
    let id: Int
    let deaths: Deaths
    init(_ id: Int, deaths: Deaths) {
        self.id = id
        self.deaths = deaths
    }
    deinit { deaths.ids.append(id) }
}

@Suite struct `Storage adapters preserve ownership` {
    @Test
    func `move initialization transfers noncopyable values exactly once`() {
        let deaths = Deaths()
        let source = UnsafeMutablePointer<Token>.allocate(capacity: 2)
        let target = UnsafeMutablePointer<Token>.allocate(capacity: 2)
        unsafe source.initialize(to: Token(id: 1, deaths: deaths))
        unsafe source.advanced(by: 1).initialize(to: Token(id: 2, deaths: deaths))
        let count = Tagged<Token, Cardinal>(Cardinal(2))

        unsafe target.move.initialize(from: source, count: count)
        #expect(unsafe target.pointee.id == 1)
        #expect(unsafe target.advanced(by: 1).pointee.id == 2)
        #expect(deaths.ids.isEmpty)

        unsafe source.deallocate()
        unsafe target.deinitialize(count: count)
        unsafe target.deallocate()
        #expect(deaths.ids.sorted() == [1, 2])
    }

    @Test
    func `move updates destroy replaced objects and transfer source objects`() {
        let deaths = Deaths()
        let source = UnsafeMutablePointer<Object>.allocate(capacity: 2)
        let target = UnsafeMutablePointer<Object>.allocate(capacity: 2)
        unsafe source.initialize(to: Object(1, deaths: deaths))
        unsafe source.advanced(by: 1).initialize(to: Object(2, deaths: deaths))
        unsafe target.initialize(to: Object(3, deaths: deaths))
        unsafe target.advanced(by: 1).initialize(to: Object(4, deaths: deaths))
        let count = Tagged<Object, Cardinal>(Cardinal(2))

        unsafe target.move.update(from: source, count: count)
        #expect(unsafe target.pointee.id == 1)
        #expect(unsafe target.advanced(by: 1).pointee.id == 2)
        #expect(deaths.ids.sorted() == [3, 4])

        unsafe source.deallocate()
        unsafe target.deinitialize(count: count)
        unsafe target.deallocate()
        #expect(deaths.ids.sorted() == [1, 2, 3, 4])
    }

    @Test
    func `zero count moves leave both initialized regions unchanged`() {
        let source = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        let target = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        unsafe source.initialize(to: 10)
        unsafe target.initialize(to: 20)
        let zero = Tagged<Int, Cardinal>(Cardinal(UInt.zero))
        unsafe target.move.initialize(from: source, count: zero)
        unsafe target.move.update(from: source, count: zero)
        #expect(unsafe source.pointee == 10)
        #expect(unsafe target.pointee == 20)
        unsafe source.deinitialize(count: 1)
        unsafe target.deinitialize(count: 1)
        unsafe source.deallocate()
        unsafe target.deallocate()
    }

    @Test
    func `equal and distinct typed swaps preserve class destruction`() {
        let deaths = Deaths()
        let values = UnsafeMutablePointer<Object>.allocate(capacity: 2)
        unsafe values.initialize(to: Object(1, deaths: deaths))
        unsafe values.advanced(by: 1).initialize(to: Object(2, deaths: deaths))
        let first = Tagged<Object, Ordinal>(Ordinal.zero)
        let last = Tagged<Object, Ordinal>(Ordinal(1))

        unsafe values.swap(first, first)
        #expect(unsafe values[first].id == 1)
        unsafe values.swap(first, last)
        #expect(unsafe values[first].id == 2)
        #expect(unsafe values[last].id == 1)
        #expect(deaths.ids.isEmpty)

        unsafe values.deinitialize(count: Tagged<Object, Cardinal>(Cardinal(2)))
        unsafe values.deallocate()
        #expect(deaths.ids.sorted() == [1, 2])
    }
}
