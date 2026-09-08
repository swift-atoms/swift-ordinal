#if SYNCHRONIZATION_AVAILABLE
import Synchronization
#endif


extension Ordinal: Swift.CustomStringConvertible {

    public var description: String { rawValue.description }
}
