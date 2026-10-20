public import Cardinal
public import Carrier
public import Distance
public import Property

extension Ordinal.`Protocol` {

    @inlinable
    public var distance: Property<Distance, Self> {
        Property(self)
    }
}

extension Property where Tag == Distance, Base: Ordinal.`Protocol` {

    @inlinable
    public func forward(to other: Base) throws(Ordinal.Error) -> Base.Count {
        do {
            return Base.Count(
                Cardinal(
                    try Distance.exact(
                        from: base.ordinal.rawValue,
                        to: other.ordinal.rawValue
                    )
                )
            )
        } catch {
            throw .notForward
        }
    }
}

extension Property where Tag == Distance, Base: Ordinal.`Protocol` {

    @inlinable
    public func unchecked(to other: Base) -> Base.Count {
        let result = Distance.reporting(
            from: base.ordinal.rawValue,
            to: other.ordinal.rawValue
        )
        precondition(!result.overflow, "Distance is not forward")
        return Base.Count(Cardinal(result.value))
    }
}
