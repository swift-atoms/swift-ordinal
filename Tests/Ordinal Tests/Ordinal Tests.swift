import Ordinal_Standard_Library_Integration
import Testing

@testable import Ordinal

extension Ordinal {
    @Suite
    struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
        @Suite(.serialized) struct Performance {}
    }
}

extension Ordinal.Test.Unit {

    @Test
    func `construction from UInt`() {
        let position: Ordinal = 42
        #expect(position == 42)
    }

    @Test
    func `zero constant`() {
        #expect(Ordinal.zero == 0)
    }

    @Test
    func comparison() {
        let a: Ordinal = 3
        let b: Ordinal = 5
        #expect(a < b)
        #expect(a <= b)
        #expect(b > a)
        #expect(b >= a)
        #expect(a == a)
    }
}
