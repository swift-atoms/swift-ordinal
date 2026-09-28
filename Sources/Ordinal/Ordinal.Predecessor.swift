public import Predecessor
public import Property

extension Ordinal.`Protocol` {
    @inlinable
    public var predecessor: Property<Predecessor, Self> {
        Property(self)
    }
}

extension Property where Tag == Predecessor, Base: Ordinal.`Protocol` {

    @inlinable
    public func saturating() -> Base {
        Base(Ordinal(Predecessor.saturating(base.ordinal.rawValue)))
    }

    @inlinable
    public func exact() throws(Ordinal.Error) -> Base {
        do {
            return Base(Ordinal(try Predecessor.exact(base.ordinal.rawValue)))
        } catch {
            throw .underflow
        }
    }
}

