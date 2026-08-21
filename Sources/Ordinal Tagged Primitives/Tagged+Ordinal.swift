public import Cardinal_Primitives
public import Ordinal_Cardinal_Primitives
public import Ordinal_Primitive
public import Tagged_Primitives

extension Tagged where Underlying == Ordinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public var position: Ordinal { underlying }

    @inlinable
    public static var zero: Self { .init(_unchecked: .zero) }
}

extension Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init(_ index: Tagged<Tag, Ordinal>) {
        self = index.map(Cardinal.init)
    }
}
