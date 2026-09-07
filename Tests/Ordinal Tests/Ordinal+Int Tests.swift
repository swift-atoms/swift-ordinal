import Ordinal
import Testing

extension Ordinal {
    @Suite
    struct `Int Conversion` {}
}

extension Ordinal.`Int Conversion` {

    @Test
    func `int conversion success`() throws(Ordinal.Error) {
        let position: Ordinal = 42
        let value = try Int(position)
        #expect(value == 42)
    }

    @Test
    func `int conversion exactly success`() {
        let position: Ordinal = 42
        #expect(Int(exactly: position) == 42)
    }
}
