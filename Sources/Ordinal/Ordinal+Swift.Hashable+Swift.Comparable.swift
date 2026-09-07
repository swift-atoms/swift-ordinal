#if SYNCHRONIZATION_AVAILABLE
public import Synchronization
#endif


extension Ordinal: Swift.Hashable, Swift.Comparable {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
