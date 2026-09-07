#if SYNCHRONIZATION_AVAILABLE
public import Synchronization
#endif


extension Ordinal: Swift.CustomStringConvertible {

    public var description: String { rawValue.description }
}
