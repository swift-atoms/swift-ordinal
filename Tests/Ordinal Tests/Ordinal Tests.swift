import Cardinal
import Testing

@testable import Ordinal

extension Ordinal {
    @Suite
    struct `Ordinals preserve unsigned positions through checked and saturating arithmetic` {
        @Suite struct `Ordinal construction arithmetic and conversions preserve positions and distances` {}
        @Suite struct `Ordinal boundaries distinguish saturation from typed arithmetic failures` {}
        @Suite struct `Ordinal displacement adapters preserve carrier wrappers and tagged domains` {}
        @Suite(.serialized) struct `No ordinal arithmetic performance cases are defined` {}
    }
}

extension Ordinal.`Ordinals preserve unsigned positions through checked and saturating arithmetic`.`Ordinal construction arithmetic and conversions preserve positions and distances` {

    @Test
    func `Integer literals preserve ordinal positions`() {
        let position: Ordinal = 42
        #expect(position == 42)
    }

    @Test
    func `Positive Int values construct ordinals with the same position`() throws(Ordinal.Error) {
        let position = try Ordinal(Int(42))
        #expect(position.rawValue == 42)
    }

    @Test
    func `construction exactly succeeds`() {
        #expect(Ordinal(exactly: 42) == 42)
    }

    @Test
    func `The zero ordinal represents position zero`() {
        #expect(Ordinal.zero == 0)
    }

    @Test
    func `Saturating ordinal successor advances an interior position by one`() {
        let position: Ordinal = 5
        #expect(position.successor.saturating() == 6)
    }

    @Test
    func `Exact ordinal successor advances an interior position by one`() throws(Ordinal.Error) {
        let position: Ordinal = 5
        let next = try position.successor.exact()
        #expect(next == 6)
    }

    @Test
    func `Exact ordinal predecessor retreats an interior position by one`() throws(Ordinal.Error) {
        let position: Ordinal = 5
        let prev = try position.predecessor.exact()
        #expect(prev == 4)
    }

    @Test
    func `Exact ordinal successor followed by predecessor restores the position`() throws(Ordinal.Error) {
        let position: Ordinal = 5
        let result = try position.successor.exact().predecessor.exact()
        #expect(result == position)
    }

    @Test
    func `Saturating ordinal advancement adds a representable count`() {
        let position: Ordinal = 5
        let count: Cardinal = 3
        #expect(position.advance.saturating(by: count) == 8)
    }

    @Test
    func `Exact ordinal advancement adds a representable count`() throws(Ordinal.Error) {
        let position: Ordinal = 5
        let count: Cardinal = 3
        let result = try position.advance.exact(by: count)
        #expect(result == 8)
    }

    @Test
    func `Forward ordinal distance counts the positions between ordered endpoints`() throws(Ordinal.Error) {
        let a: Ordinal = 3
        let b: Ordinal = 8
        let distance = try a.distance.forward(to: b)
        #expect(distance == 5)
    }

    @Test
    func `Forward ordinal distance from a position to itself is zero`() throws(Ordinal.Error) {
        let position: Ordinal = 5
        let distance = try position.distance.forward(to: position)
        #expect(distance == 0)
    }

    @Test
    func `Ordinal comparisons follow their unsigned positions`() {
        let a: Ordinal = 3
        let b: Ordinal = 5
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == a)
        #expect(a != b)
    }

    @Test
    func `Cardinal conversion preserves the requested ordinal position`() {
        let count: Cardinal = 42
        let position = Ordinal(count)
        #expect(position == 42)
    }

    @Test
    func `Ordinal conversion preserves the resulting Cardinal count`() {
        let position: Ordinal = 42
        let count = Cardinal(position)
        #expect(count == 42)
    }
}

extension Ordinal.`Ordinals preserve unsigned positions through checked and saturating arithmetic`.`Ordinal boundaries distinguish saturation from typed arithmetic failures` {

    @Test
    func `construction from int fails for negative`() {
        #expect(throws: Ordinal.Error.negativeSource(-1)) {
            try Ordinal(Int(-1))
        }
    }

    @Test
    func `construction exactly returns nil for negative`() {
        #expect(Ordinal(exactly: Int(-1)) == nil)
    }

    @Test
    func `Saturating ordinal successor preserves the maximum position`() {
        let max = Ordinal(UInt.max)
        #expect(max.successor.saturating() == max)
    }

    @Test
    func `successor exact throws at max`() {
        let max = Ordinal(UInt.max)
        #expect(throws: Ordinal.Error.overflow) {
            try max.successor.exact()
        }
    }

    @Test
    func `predecessor exact throws at zero`() {
        #expect(throws: Ordinal.Error.underflow) {
            try Ordinal.zero.predecessor.exact()
        }
    }

    @Test
    func `retreat clamped returns the bound when the bound exceeds the base`() {
        let base: Ordinal = 3
        let bound: Ordinal = 8
        #expect(base.retreat.clamped(by: 1, to: bound) == bound)
        #expect(base.retreat.clamped(by: 0, to: bound) == bound)
    }

    @Test
    func `retreat clamped clamps when the count overshoots the bound`() {
        let base: Ordinal = 8
        let bound: Ordinal = 3
        #expect(base.retreat.clamped(by: 10, to: bound) == bound)
        #expect(base.retreat.clamped(by: 5, to: bound) == bound)
    }

    @Test
    func `retreat clamped retreats exactly when in range`() {
        let base: Ordinal = 8
        let bound: Ordinal = 3
        #expect(base.retreat.clamped(by: 2, to: bound) == 6)
        #expect(base.retreat.clamped(by: 0, to: bound) == base)
        #expect(base.retreat.clamped(by: 4, to: bound) == 4)
    }

    @Test
    func `Saturating ordinal advancement clamps an overflowing sum to the maximum`() {
        let position = Ordinal(UInt.max - 5)
        let count: Cardinal = 10
        #expect(position.advance.saturating(by: count).rawValue == UInt.max)
    }

    @Test
    func `advance exact throws on overflow`() {
        let position = Ordinal(UInt.max - 5)
        let count: Cardinal = 10
        #expect(throws: Ordinal.Error.overflow) {
            try position.advance.exact(by: count)
        }
    }

    @Test
    func `distance forward throws when backward`() {
        let a: Ordinal = 8
        let b: Ordinal = 3
        #expect(throws: Ordinal.Error.notForward) {
            try a.distance.forward(to: b)
        }
    }
}
