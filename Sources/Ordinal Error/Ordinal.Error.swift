public import Ordinal_Primitive

extension Ordinal {

    public enum Error: Swift.Error, Hashable, Sendable {

        case overflow

        case underflow

        case negativeSource(Int)

        case notForward
    }
}
