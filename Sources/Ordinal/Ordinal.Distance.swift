public import Cardinal
public import Carrier
public import Subtraction
public import Property

extension Ordinal.`Protocol` {

    @inlinable
    public var distance: Property<Ordinal.Distance, Self> {
        Property(self)
    }
}

extension Property where Tag == Ordinal.Distance, Base: Ordinal.`Protocol` {

    @inlinable
    public func forward(to other: Base) throws(Ordinal.Error) -> Base.Count {
        do {
            return Base.Count(
                Cardinal(
                    try Subtraction.exact(other.ordinal.rawValue, base.ordinal.rawValue)
                )
            )
        } catch {
            throw .notForward
        }
    }
}

extension Property where Tag == Ordinal.Distance, Base: Ordinal.`Protocol` {

    @inlinable
    public func unchecked(to other: Base) -> Base.Count {
        let result = Subtraction.reporting(other.ordinal.rawValue, base.ordinal.rawValue)
        precondition(!result.overflow, "Distance is not forward")
        return Base.Count(Cardinal(result.value))
    }
}
