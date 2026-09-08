#if SYNCHRONIZATION_AVAILABLE
import Synchronization
#endif


extension Ordinal: Swift.ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}
