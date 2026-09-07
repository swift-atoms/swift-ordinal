public import Cardinal
public import Property
public import Tagged

extension Property::Property {

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
