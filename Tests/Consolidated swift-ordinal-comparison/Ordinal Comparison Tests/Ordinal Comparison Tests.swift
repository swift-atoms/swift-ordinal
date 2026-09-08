import Comparison
import Ordinal
import Testing

@Suite
struct `Ordinal Comparison Tests` {

    @Test
    func `Ordinal satisfies Comparison Protocol`() {
        func compare<T: Comparison.`Protocol`>(_ lhs: T, _ rhs: T) -> Comparison {
            Comparison(lhs, rhs)
        }

        #expect(compare(Ordinal(1), Ordinal(2)) == .less)
        #expect(compare(Ordinal(2), Ordinal(2)) == .equal)
        #expect(compare(Ordinal(3), Ordinal(2)) == .greater)
    }
}
