public import Difference
public import Tagged

extension Swift.UnsafePointer {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Pointee {
        guard let index = Int(exactly: position.ordinal) else {
            preconditionFailure("Pointer position is not representable as Int")
        }
        return unsafe self[index]
    }
}

@_transparent
public func + <Pointee: ~Copyable>(
    lhs: UnsafePointer<Pointee>,
    rhs: Tagged<Pointee, Ordinal>.Offset
) -> UnsafePointer<Pointee> {
    guard let offset = try? rhs.difference.intValue() else {
        preconditionFailure("Pointer offset is not representable as Int")
    }
    return unsafe lhs.advanced(by: offset)
}

@_transparent
public func + <Pointee: ~Copyable>(
    lhs: Tagged<Pointee, Ordinal>.Offset,
    rhs: UnsafePointer<Pointee>
) -> UnsafePointer<Pointee> {
    unsafe rhs + lhs
}

@_transparent
public func - <Pointee: ~Copyable>(
    lhs: UnsafePointer<Pointee>,
    rhs: Tagged<Pointee, Ordinal>.Offset
) -> UnsafePointer<Pointee> {
    guard let offset = try? (-rhs.difference).intValue() else {
        preconditionFailure("Pointer offset is not representable as Int")
    }
    return unsafe lhs.advanced(by: offset)
}

@_transparent
public func - <Pointee: ~Copyable>(
    lhs: UnsafePointer<Pointee>,
    rhs: UnsafePointer<Pointee>
) -> Tagged<Pointee, Ordinal>.Offset {
    Tagged<Pointee, Ordinal>.Offset(
        _unchecked: Difference(unsafe rhs.distance(to: lhs))
    )
}

extension Swift.UnsafePointer where Pointee: ~Copyable {

    @inlinable @inline(always)
    public subscript(index: Tagged<Pointee, Ordinal>) -> Pointee {
        @_transparent
        unsafeAddress {
            unsafe self + Tagged<Pointee, Ordinal>.Offset(fromZero: index)
        }
    }
}
