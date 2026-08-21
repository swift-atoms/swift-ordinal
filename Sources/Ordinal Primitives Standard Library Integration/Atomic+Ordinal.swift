#if SYNCHRONIZATION_AVAILABLE
    public import Cardinal_Primitives
    public import Ordinal_Cardinal_Primitives
    public import Ordinal_Primitive
    public import Ordinal_Protocol_Primitives
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
