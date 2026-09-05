public import Successor
public import Property

extension Ordinal.`Protocol` {
    @inlinable
    public var successor: Property<Successor, Self> {
        Property(self)
    }
}

extension Property where Tag == Successor, Base: Ordinal.`Protocol` {

    @inlinable
    public func saturating() -> Base {
        Base(Ordinal(Successor.saturating(base.ordinal.rawValue)))
    }

    @inlinable
    public func exact() throws(Ordinal.Error) -> Base {
        do {
            return Base(Ordinal(try Successor.exact(base.ordinal.rawValue)))
        } catch {
            throw .overflow
        }
    }
}
