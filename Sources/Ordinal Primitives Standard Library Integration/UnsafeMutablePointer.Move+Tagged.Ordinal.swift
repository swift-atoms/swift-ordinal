public import Cardinal_Primitives_Standard_Library_Integration
public import Property_Primitives
public import Tagged_Primitives

extension UnsafeMutablePointer where Pointee: ~Copyable {

    public enum Move {}
}

extension UnsafeMutablePointer where Pointee: ~Copyable {

    @inlinable
    public var move: Property_Primitives.Property<Move, Self> {
        unsafe Property_Primitives.Property(self)
    }
}

extension Property_Primitives.Property {

    @inlinable
    public func initialize<Pointee: ~Copyable>(
        from source: UnsafeMutablePointer<Pointee>,
        count: Tagged<Pointee, Ordinal>.Count
    ) where Tag == UnsafeMutablePointer<Pointee>.Move, Base == UnsafeMutablePointer<Pointee> {
        unsafe base.moveInitialize(
            from: source,
            count: Int(bitPattern: count.underlying)
        )
    }

    @inlinable
    public func update<Pointee>(
        from source: UnsafeMutablePointer<Pointee>,
        count: Tagged<Pointee, Ordinal>.Count
    ) where Tag == UnsafeMutablePointer<Pointee>.Move, Base == UnsafeMutablePointer<Pointee> {
        unsafe base.moveUpdate(from: source, count: Int(bitPattern: count.underlying))
    }
}
