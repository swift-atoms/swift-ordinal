import Ordinal
import Testing

@Test
func `standard conformances are intrinsic`() {
    let two: Ordinal::Ordinal = 2
    let three = Ordinal::Ordinal(UInt8(3))

    #expect(two < three)
    #expect(Set([two, two, three]).count == 2)
    #expect(two.description == "2")
}
