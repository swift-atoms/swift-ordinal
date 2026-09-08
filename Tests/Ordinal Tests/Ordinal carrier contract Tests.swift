import Ordinal
import Testing

@Suite
struct `Ordinals conform to the carrier contract` {
    @Test
    func `Underlying representation is the ordinal itself`() {
        let ordinal = Ordinal(42 as UInt)

        #expect(ordinal.underlying.rawValue == 42)
    }

    @Test
    func `Carrier initializer preserves the ordinal`() {
        let original = Ordinal(42 as UInt)
        let carried = Ordinal(original)

        #expect(carried.rawValue == original.rawValue)
    }

    @Test
    func `Conformance works through a generic Carrier operation`() {
        func roundTrip<Value: Carrier.`Protocol`>(_ value: consuming Value) -> Value
        where Value.Underlying == Value {
            Value(value)
        }

        #expect(roundTrip(Ordinal(42 as UInt)).rawValue == 42)
    }
}
