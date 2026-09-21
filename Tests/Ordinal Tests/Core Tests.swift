import Ordinal
import Testing

@Suite struct `Core ordinal values` {
    @Test func `positions retain ordering and exact integer conversion`() {
        #expect(Ordinal(UInt(2)) < Ordinal(UInt(3)))
        #expect(Ordinal(exactly: -1) == nil)
        #expect(Ordinal(exactly: 2) == Ordinal(UInt(2)))
    }
}
