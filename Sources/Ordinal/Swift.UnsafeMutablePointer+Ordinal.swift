public import Cardinal
public import Property
public import Tagged

extension Swift.UnsafeMutablePointer where Pointee: ~Copyable {

    public enum Move {}
}

extension Swift.UnsafeMutablePointer where Pointee: ~Copyable {

    @inlinable
    public var move: Property::Property<Move, Self> {
        unsafe Property::Property(self)
    }
}

public import Difference

extension Swift.UnsafeMutablePointer {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Pointee {
        get {
            guard let index = Int(exactly: position.ordinal) else {
                preconditionFailure("Pointer position is not representable as Int")
            }
            return unsafe self[index]
        }
        nonmutating set {
            guard let index = Int(exactly: position.ordinal) else {
                preconditionFailure("Pointer position is not representable as Int")
            }
            unsafe self[index] = newValue
        }
    }
}

@_transparent
public func + <Pointee: ~Copyable>(
    lhs: UnsafeMutablePointer<Pointee>,
    rhs: Tagged<Pointee, Ordinal>.Offset
) -> UnsafeMutablePointer<Pointee> {
    guard let offset = try? rhs.difference.intValue() else {
        preconditionFailure("Pointer offset is not representable as Int")
    }
    return unsafe lhs.advanced(by: offset)
}

@_transparent
public func + <Pointee: ~Copyable>(
    lhs: Tagged<Pointee, Ordinal>.Offset,
    rhs: UnsafeMutablePointer<Pointee>
) -> UnsafeMutablePointer<Pointee> {
    unsafe rhs + lhs
}

@_transparent
public func - <Pointee: ~Copyable>(
    lhs: UnsafeMutablePointer<Pointee>,
    rhs: Tagged<Pointee, Ordinal>.Offset
) -> UnsafeMutablePointer<Pointee> {
    guard let offset = try? (-rhs.difference).intValue() else {
        preconditionFailure("Pointer offset is not representable as Int")
    }
    return unsafe lhs.advanced(by: offset)
}

@_transparent
public func - <Pointee: ~Copyable>(
    lhs: UnsafeMutablePointer<Pointee>,
    rhs: UnsafeMutablePointer<Pointee>
) -> Tagged<Pointee, Ordinal>.Offset {
    Tagged<Pointee, Ordinal>.Offset(
        _unchecked: Difference(unsafe rhs.distance(to: lhs))
    )
}

extension Swift.UnsafeMutablePointer where Pointee: ~Copyable {

    @inlinable @inline(always)
    public subscript(index: Tagged<Pointee, Ordinal>) -> Pointee {
        @_transparent
        unsafeAddress {
            unsafe UnsafePointer(self + Tagged<Pointee, Ordinal>.Offset(fromZero: index))
        }
        @_transparent
        nonmutating unsafeMutableAddress {
            unsafe self + Tagged<Pointee, Ordinal>.Offset(fromZero: index)
        }
    }

    @inlinable
    public func swap(
        _ i: Tagged<Pointee, Ordinal>,
        _ j: Tagged<Pointee, Ordinal>
    ) {
        let ptrI = unsafe self + Tagged<Pointee, Ordinal>.Offset(fromZero: i)
        let ptrJ = unsafe self + Tagged<Pointee, Ordinal>.Offset(fromZero: j)
        guard unsafe ptrI != ptrJ else { return }
        let temporary = unsafe ptrI.move()
        unsafe ptrI.initialize(to: ptrJ.move())
        unsafe ptrJ.initialize(to: temporary)
    }
}

extension Swift.UnsafeMutablePointer {

    @inlinable
    public static func allocate(
        capacity: Tagged<Pointee, Ordinal>.Count
    ) -> UnsafeMutablePointer {
        Self.allocate(capacity: Int(capacity.underlying.rawValue))
    }

    @inlinable
    public func initialize(
        repeating repeatedValue: Pointee,
        count: Tagged<Pointee, Ordinal>.Count
    ) {
        unsafe self.initialize(
            repeating: repeatedValue,
            count: Int(count.underlying.rawValue)
        )
    }

    @inlinable
    public func initialize(
        from source: UnsafePointer<Pointee>,
        count: Tagged<Pointee, Ordinal>.Count
    ) {
        unsafe self.initialize(
            from: source,
            count: Int(count.underlying.rawValue)
        )
    }

    @inlinable
    public func update(
        repeating repeatedValue: Pointee,
        count: Tagged<Pointee, Ordinal>.Count
    ) {
        unsafe self.update(
            repeating: repeatedValue,
            count: Int(count.underlying.rawValue)
        )
    }
}

extension Swift.UnsafeMutablePointer where Pointee: ~Copyable {

    @inlinable
    @discardableResult
    public func deinitialize(
        count: Tagged<Pointee, Ordinal>.Count
    ) -> UnsafeMutableRawPointer {
        unsafe self.deinitialize(count: Int(count.underlying.rawValue))
    }
}
