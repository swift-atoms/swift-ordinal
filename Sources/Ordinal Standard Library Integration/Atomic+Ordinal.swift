#if SYNCHRONIZATION_AVAILABLE
    public import Cardinal
    public import Ordinal_Cardinal
    public import Ordinal
    public import Ordinal_Protocol
    public import Synchronization

    extension Atomic
    where
        Value: Ordinal.`Protocol` & AtomicRepresentable,
        Value.AtomicRepresentation == UInt.AtomicRepresentation
    {

        @inlinable
        public func advance<C: Carrier.`Protocol`<Cardinal>>(
            within capacity: C
        ) -> Value
        where Value.Domain == C.Domain {
            while true {
                let current = load(ordering: .relaxed)
                let next = (current + C.one) % capacity
                let result = compareExchange(
                    expected: current,
                    desired: next,
                    successOrdering: .relaxed,
                    failureOrdering: .relaxed
                )
                if result.exchanged { return current }
            }
        }
    }
#endif
