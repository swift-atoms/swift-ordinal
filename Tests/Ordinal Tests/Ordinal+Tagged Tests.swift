#if Tagged
import Cardinal
import Ordinal
import Tagged
import Testing

@testable import Ordinal

private enum SlotPosition {}
private enum LanePosition {}

extension Ordinal {
    @Suite
    struct `Tagged ordinals retain their position domain through arithmetic and conversion` {
        @Suite struct `Tagged ordinal operations preserve positions counts and ranges` {}
        @Suite struct `Tagged ordinal arithmetic reports boundary failures` {}
        @Suite struct `Tagged ordinal conversions preserve exact values and explicit bit patterns` {}
        @Suite(.serialized) struct `No tagged ordinal performance cases are defined` {}
    }
}

extension Ordinal.`Tagged ordinals retain their position domain through arithmetic and conversion`.`Tagged ordinal operations preserve positions counts and ranges` {

    @Test
    func `Tagged ordinal construction preserves its underlying position`() {
        let slot = Tagged::Tagged<SlotPosition, Ordinal>(Ordinal(3))
        #expect(slot.position == Ordinal(3))
    }

    @Test
    func `Tagged ordinal literals retain the requested position`() {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        #expect(slot.position == 5)
    }

    @Test
    func `The zero ordinal represents position zero`() {
        #expect(Tagged::Tagged<SlotPosition, Ordinal>.zero == 0)
        #expect(Tagged::Tagged<SlotPosition, Ordinal>.zero.position == .zero)
    }

    @Test
    func `Equal tagged ordinal values compare equally within one domain`() {

        let slotA: Tagged::Tagged<SlotPosition, Ordinal> = 7
        let slotB: Tagged::Tagged<SlotPosition, Ordinal> = 7
        #expect(slotA == slotB)
    }

    @Test
    func `Saturating ordinal successor advances an interior position by one`() {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let next = slot.successor.saturating()
        #expect(next == 6)
    }

    @Test
    func `Exact ordinal successor advances an interior position by one`() throws(Ordinal.Error) {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let next = try slot.successor.exact()
        #expect(next == 6)
    }

    @Test
    func `Exact ordinal predecessor retreats an interior position by one`() throws(Ordinal.Error) {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let prev = try slot.predecessor.exact()
        #expect(prev == 4)
    }

    @Test
    func `Saturating tagged advancement adds a count from the same domain`() {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let count: Tagged::Tagged<SlotPosition, Cardinal> = 3
        let result = slot.advance.saturating(by: count)
        #expect(result == 8)
    }

    @Test
    func `Exact tagged advancement adds a count from the same domain`() throws(Ordinal.Error) {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let count: Tagged::Tagged<SlotPosition, Cardinal> = 3
        let result = try slot.advance.exact(by: count)
        #expect(result == 8)
    }

    @Test
    func `Exact tagged retreat subtracts a count from the same domain`() throws(Ordinal.Error) {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let count: Tagged::Tagged<SlotPosition, Cardinal> = 3
        let result = try slot.retreat.exact(by: count)
        #expect(result == 2)
    }

    @Test
    func `Tagged ordinal addition advances by the supplied count`() {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let count: Tagged::Tagged<SlotPosition, Cardinal> = 3
        let result = slot + count
        #expect(result == 8)
    }

    @Test
    func `Forward tagged distance returns a count in the same domain`() throws(Ordinal.Error) {
        let a: Tagged::Tagged<SlotPosition, Ordinal> = 3
        let b: Tagged::Tagged<SlotPosition, Ordinal> = 8
        let distance = try a.distance.forward(to: b)
        #expect(distance == Tagged::Tagged<SlotPosition, Cardinal>(5))
    }

    @Test
    func `Unchecked forward distance counts the positions between ordered ordinals`() {

        let a: Ordinal = 3
        let b: Ordinal = 8
        let distance = a.distance.unchecked(to: b)
        #expect(distance == Cardinal(5))
    }

    @Test
    func `A tagged ordinal range exposes its count in the same domain`() {
        let lower: Tagged::Tagged<SlotPosition, Ordinal> = 3
        let upper: Tagged::Tagged<SlotPosition, Ordinal> = 8
        let range = lower..<upper
        #expect(range.count == Tagged::Tagged<SlotPosition, Cardinal>(5))
    }

    @Test
    func `range is empty when equal`() {
        let position: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let range = position..<position
        #expect(range.isEmpty)
    }

    @Test
    func `A tagged range derives its upper bound from the start and count`() {
        let start: Tagged::Tagged<SlotPosition, Ordinal> = 3
        let count: Tagged::Tagged<SlotPosition, Cardinal> = 5
        let range = Swift.Range(start: start, count: count)
        #expect(range.lowerBound == start)
        #expect(range.upperBound == 8)
    }

    @Test
    func `A tagged ordinal converts to a count in the same domain`() {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 5
        let count = Tagged::Tagged<SlotPosition, Cardinal>(slot)
        #expect(count == 5)
    }
}

extension Ordinal.`Tagged ordinals retain their position domain through arithmetic and conversion`.`Tagged ordinal arithmetic reports boundary failures` {

    @Test
    func `successor exact throws at max`() {
        let max = Tagged::Tagged<SlotPosition, Ordinal>(Ordinal(UInt.max))
        #expect(throws: Ordinal.Error.overflow) {
            try max.successor.exact()
        }
    }

    @Test
    func `predecessor exact throws at zero`() {
        #expect(throws: Ordinal.Error.underflow) {
            try Tagged::Tagged<SlotPosition, Ordinal>.zero.predecessor.exact()
        }
    }

    @Test
    func `advance exact tagged count throws on overflow`() {
        let slot = Tagged::Tagged<SlotPosition, Ordinal>(Ordinal(UInt.max - 5))
        let count: Tagged::Tagged<SlotPosition, Cardinal> = 10
        #expect(throws: Ordinal.Error.overflow) {
            try slot.advance.exact(by: count)
        }
    }

    @Test
    func `distance forward throws when backward`() {
        let a: Tagged::Tagged<SlotPosition, Ordinal> = 8
        let b: Tagged::Tagged<SlotPosition, Ordinal> = 3
        #expect(throws: Ordinal.Error.notForward) {
            try a.distance.forward(to: b)
        }
    }
}

extension Ordinal.`Tagged ordinals retain their position domain through arithmetic and conversion`.`Tagged ordinal conversions preserve exact values and explicit bit patterns` {

    @Test
    func `Failable tagged ordinal conversion returns the exact Int value`() {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 42
        #expect(Int(exactly: slot) == 42)
    }

    @Test
    func `Throwing tagged ordinal conversion returns the exact Int value`() throws(Ordinal.Error) {
        let slot: Tagged::Tagged<SlotPosition, Ordinal> = 42
        let value = try Int(slot)
        #expect(value == 42)
    }

    @Test
    func `Tagged ordinal bit pattern conversion preserves every unsigned bit`() {
        let slot = Tagged::Tagged<SlotPosition, Ordinal>(Ordinal(UInt.max))
        let bits = Int(bitPattern: slot)
        #expect(bits == -1)
    }
}

#endif
