public import Advancement
public import Cardinal
public import Property

extension Ordinal.`Protocol` {

    @inlinable
    public var advance: Property<Advancement, Self> {
        Property(self)
    }
}

extension Property where Tag == Advancement, Base: Ordinal.`Protocol` {

    @inlinable
    public func saturating(by count: Base.Count) -> Base {
        Base(
            Ordinal(
                Advancement.saturating(
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
                    try Advancement.exact(
                        base.ordinal.rawValue,
                        by: count.cardinal.rawValue
                    )
                )
            )
        } catch {
            throw .overflow
        }
    }

    @inlinable
    public func clamped(
        by count: Base.Count,
        to bound: Base
    ) -> Base {
        let result = Advancement.reporting(
            base.ordinal.rawValue,
            by: count.cardinal.rawValue
        )
        if result.overflow || result.value > bound.ordinal.rawValue {
            return bound
        }
        return Base(Ordinal(result.value))
    }
}

