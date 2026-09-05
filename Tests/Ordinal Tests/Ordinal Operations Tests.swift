import Cardinal
import Ordinal
import Tagged
import Testing

private enum StepDomain {}

private struct Step: Ordinal.`Protocol`, Equatable {
    typealias Domain = StepDomain
    typealias Count = Tagged<StepDomain, Cardinal>

    let ordinal: Ordinal

    init(_ ordinal: Ordinal) {
        self.ordinal = ordinal
    }
}

@Suite
struct `Ordinal Generic Operation Tests` {

    @Test
    func `successor and predecessor preserve a custom ordinal carrier`() throws {
        let position = Step(Ordinal(4))
        let successor: Step = try position.successor.exact()
        let predecessor: Step = try successor.predecessor.exact()

        #expect(successor == Step(Ordinal(5)))
        #expect(predecessor == position)
    }

    @Test
    func `advancement and retreat use the custom carrier count domain`() throws {
        let position = Step(Ordinal(4))
        let count = Step.Count(_unchecked: Cardinal(3))
        let advanced: Step = try position.advance.exact(by: count)
        let retreated: Step = try advanced.retreat.exact(by: count)

        #expect(advanced == Step(Ordinal(7)))
        #expect(retreated == position)
    }

    @Test
    func `clamping and forward distance preserve the custom carrier`() throws {
        let position = Step(Ordinal(4))
        let bound = Step(Ordinal(6))
        let count = Step.Count(_unchecked: Cardinal(8))
        let clamped: Step = position.advance.clamped(by: count, to: bound)
        let distance: Step.Count = try position.distance.forward(to: clamped)

        #expect(clamped == bound)
        #expect(distance.cardinal == Cardinal(2))
    }
}
