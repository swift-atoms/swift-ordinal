#if SYNCHRONIZATION_AVAILABLE
public import Cardinal
#endif

#if SYNCHRONIZATION_AVAILABLE
public import Carrier
#endif

#if SYNCHRONIZATION_AVAILABLE
public import Synchronization
#endif

#if SYNCHRONIZATION_AVAILABLE
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

