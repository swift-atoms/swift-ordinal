#if Tagged
public import Cardinal
public import Property
public import Retreat

extension Ordinal.`Protocol` {

    @inlinable
    public var retreat: Property<Retreat, Self> {
        Property(self)
    }
}

extension Property where Tag == Retreat, Base: Ordinal.`Protocol` {

    @inlinable
    public func saturating(by count: Base.Count) -> Base {
        Base(
            Ordinal(
                Retreat.saturating(
                    base.ordinal.rawValue,
                    by: count.cardinal.rawValue
                )
            )
        )
    }

    @inlinable
    public func exact(by count: Base.Count) throws(Ordinal.Error) -> Base {
        do {
            return Base(
                Ordinal(
                    try Retreat.exact(
                        base.ordinal.rawValue,
                        by: count.cardinal.rawValue
                    )
                )
            )
        } catch {
            throw .underflow
        }
    }

    @inlinable
    public func clamped(
        by count: Base.Count,
        to bound: Base
    ) -> Base {

        guard bound.ordinal < base.ordinal else {
            return bound
        }

        let result = Retreat.reporting(
            base.ordinal.rawValue,
            by: count.cardinal.rawValue
        )
        if result.overflow || result.value < bound.ordinal.rawValue {
            return bound
        }
        return Base(Ordinal(result.value))
    }
}

#endif
