public import Ordinal_Error_Primitives
public import Ordinal_Primitive
public import Property_Primitives
public import Tagged_Primitives

extension Tagged where Underlying == Ordinal, Tag: ~Copyable & ~Escapable {

    public enum Predecessor {}
}

extension Tagged where Underlying == Ordinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public var predecessor: Property<Predecessor, Self> {
        Property(self)
    }
}

extension Property {

    @inlinable
    public func exact<T: ~Copyable & ~Escapable>() throws(Ordinal.Error) -> Base
    where
        Tag == Tagged<T, Ordinal>.Predecessor,
        Base == Tagged<T, Ordinal>
    {
        try base.map { ordinal throws(Ordinal.Error) in try ordinal.predecessor.exact() }
    }
}
