import Equation
import Ordinal
import Testing

@Suite
struct `Ordinal Equation Tests` {
    @Test
    func `Ordinal satisfies Equation Protocol`() {
        func acceptsEquationProtocol<T: Equation.`Protocol`>(_ value: T) -> T {
            value
        }

        let ordinal = Ordinal(UInt(3))
        #expect(acceptsEquationProtocol(ordinal) == ordinal)
    }

    @Test
    func `Equal ordinals compare equal`() {
        #expect(Ordinal(UInt(3)) == Ordinal(UInt(3)))
    }

    @Test
    func `Different ordinals compare unequal`() {
        #expect(Ordinal(UInt(2)) != Ordinal(UInt(3)))
    }
}
