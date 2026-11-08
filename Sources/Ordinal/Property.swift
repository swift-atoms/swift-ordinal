public import Cardinal
public import Property
public import Tagged

extension Property::Property {

    @inlinable
    public func initialize<Pointee: ~Copyable>(
        from source: UnsafeMutablePointer<Pointee>,
        count: Tagged<Pointee, Ordinal>.Count
    ) where Tag == UnsafeMutablePointer<Pointee>.Move, Base == UnsafeMutablePointer<Pointee> {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Move count is not representable as Int")
        }
        unsafe base.moveInitialize(
            from: source,
            count: length
        )
    }

    @inlinable
    public func update<Pointee>(
        from source: UnsafeMutablePointer<Pointee>,
        count: Tagged<Pointee, Ordinal>.Count
    ) where Tag == UnsafeMutablePointer<Pointee>.Move, Base == UnsafeMutablePointer<Pointee> {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Move count is not representable as Int")
        }
        unsafe base.moveUpdate(from: source, count: length)
    }
}
