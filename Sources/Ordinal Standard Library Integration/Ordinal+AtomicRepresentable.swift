#if SYNCHRONIZATION_AVAILABLE
    public import Ordinal
    public import Synchronization

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
