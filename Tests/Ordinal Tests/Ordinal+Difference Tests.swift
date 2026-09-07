import Cardinal
import Difference
import Ordinal
import Tagged
import Testing

private enum CoordinateDomain {}

private struct Coordinate: Ordinal.`Protocol`, Equatable {
    typealias Domain = CoordinateDomain
    typealias Count = Tagged<CoordinateDomain, Cardinal>

    let ordinal: Ordinal

    init(_ ordinal: Ordinal) {
        self.ordinal = ordinal
    }
}

private func inferredOffset<O: Ordinal.`Protocol`>(_ lhs: O, _ rhs: O) -> O.Offset {
    lhs - rhs
}

extension Ordinal.Test.Unit {

    @Test
    func `difference translates ordinal in both directions`() throws(Ordinal.Error) {
        #expect(try Ordinal(5) + Difference.positive(Difference.Magnitude(Cardinal(3))) == 8)
        #expect(try Ordinal(5) + Difference.negative(Difference.Magnitude(Cardinal(3))) == 2)
        #expect(try Ordinal(5) - Difference.positive(Difference.Magnitude(Cardinal(3))) == 2)
        #expect(try Ordinal(5) - Difference.negative(Difference.Magnitude(Cardinal(3))) == 8)
    }

    @Test
    func `ordinal subtraction is symmetric across UInt max`() {
        let zero = Ordinal.zero
        let maximum = Ordinal(UInt.max)

        #expect(maximum - zero == .positive(Difference.Magnitude(Cardinal(Cardinal.max))))
        #expect(zero - maximum == .negative(Difference.Magnitude(Cardinal(Cardinal.max))))
    }

    @Test
    func `UInt max difference round trips`() throws(Ordinal.Error) {
        let maximumDifference = Difference.positive(Difference.Magnitude(Cardinal(Cardinal.max)))
        #expect(try Ordinal.zero + maximumDifference == Ordinal(UInt.max))
        #expect(try Ordinal(UInt.max) + (-maximumDifference) == .zero)
    }

    @Test
    func `ordinal construction from difference`() throws(Ordinal.Error) {
        #expect(try Ordinal(.positive(Difference.Magnitude(Cardinal(Cardinal.max)))) == Ordinal(UInt.max))
        #expect(throws: Ordinal.Error.underflow) {
            try Ordinal(.negative(Difference.Magnitude(Cardinal(Cardinal.max))))
        }
    }
}

extension Ordinal.Test.`Edge Case` {

    @Test
    func `difference translation reports ordinal bounds`() {
        #expect(throws: Ordinal.Error.overflow) {
            try Ordinal(UInt.max) + Difference.one
        }
        #expect(throws: Ordinal.Error.underflow) {
            try Ordinal.zero + Difference.negative(Difference.Magnitude(Cardinal(Cardinal.max)))
        }
    }
}

extension Ordinal.Test.Integration {

    @Test
    func `custom ordinal carrier preserves its wrapper and domain`() throws(Ordinal.Error) {
        let position = Coordinate(5)
        let count: Coordinate.Count = 3
        let offset: Coordinate.Offset = -2

        let advanced: Coordinate = try position + offset
        #expect(advanced == Coordinate(3))
        #expect(position.advance.saturating(by: count) == Coordinate(8))
        #expect(try position.retreat.exact(by: count) == Coordinate(2))
        #expect(position.retreat.saturating(by: Coordinate.Count(8)) == Coordinate(0))
    }

    @Test
    func `tagged subtraction infers associated offset`() throws(Ordinal.Error) {
        let lower = Coordinate(3)
        let upper = Coordinate(8)
        let offset = inferredOffset(upper, lower)

        #expect(offset == Coordinate.Offset(5))
        #expect(try lower + offset == upper)
    }

    @Test
    func `tagged difference initializes from same domain ordinal`() {
        let position = Coordinate(7)
        let offset = Coordinate.Offset(fromZero: position)
        #expect(offset == Coordinate.Offset(7))
    }
}
