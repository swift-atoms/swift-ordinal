import Ordinal
import Testing

extension `Ordinal Tests` {
    @Suite
    struct `Representable ordinal positions convert exactly to Int` {}
}

extension `Ordinal Tests`.`Representable ordinal positions convert exactly to Int` {

    @Test
    func `Throwing ordinal conversion preserves a representable Int value`() throws(Ordinal.Error) {
        let position: Ordinal = 42
        let value = try Int(position)
        #expect(value == 42)
    }

    @Test
    func `Failable ordinal conversion returns a representable Int value`() {
        let position: Ordinal = 42
        #expect(Int(exactly: position) == 42)
    }
}
