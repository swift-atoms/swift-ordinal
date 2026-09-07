#if SYNCHRONIZATION_AVAILABLE
public import Synchronization
#endif


extension Ordinal {

    @inlinable
    public init<T: UnsignedInteger>(_ value: T) {
        self.init(UInt(value))
    }
}

#if SYNCHRONIZATION_AVAILABLE
extension Ordinal: AtomicRepresentable {

        public typealias AtomicRepresentation = UInt.AtomicRepresentation

        @inlinable
        public static func encodeAtomicRepresentation(
            _ value: consuming Ordinal
        ) -> AtomicRepresentation {
            UInt.encodeAtomicRepresentation(value.rawValue)
        }

        @inlinable
        public static func decodeAtomicRepresentation(
            _ representation: consuming AtomicRepresentation
        ) -> Ordinal {
            Ordinal(UInt.decodeAtomicRepresentation(representation))
        }
    }
#endif
