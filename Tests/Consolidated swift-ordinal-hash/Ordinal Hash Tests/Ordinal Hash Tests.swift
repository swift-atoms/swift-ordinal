import Hash
import Ordinal
import Testing

@Suite
struct `Ordinal Hash Tests` {

    @Test
    func `Ordinal supplies native Hashable behavior`() {
        let values: Set<Ordinal> = [Ordinal(7)]

        #expect(values.contains(Ordinal(7)))
        #expect(!values.contains(Ordinal(8)))
    }

    @Test
    func `Ordinal supplies Hash's domain-typed value`() {
        let first: Hash.Value = hash(Ordinal(7))
        let second: Hash.Value = hash(Ordinal(7))

        #expect(first == second)
    }
}

private func hash<T: Hash.`Protocol`>(_ value: borrowing T) -> Hash.Value {
    value.hashValue
}
