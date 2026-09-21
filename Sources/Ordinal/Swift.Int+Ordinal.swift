#if Tagged
public import Tagged

extension Swift.Int {

    @inlinable
    public init?(exactly position: Ordinal) {
        guard position.rawValue <= UInt(Self.max) else { return nil }
        self = Int(position.rawValue)
    }

    @inlinable
    public init(_ position: Ordinal) throws(Ordinal.Error) {
        guard position.rawValue <= UInt(Self.max) else {
            throw .overflow
        }
        self = Int(position.rawValue)
    }

    @inlinable
    public init(bitPattern position: Ordinal) {
        self = Int(bitPattern: position.rawValue)
    }

    @inlinable
    public init(bitPattern position: some Ordinal.`Protocol`) {
        self = Int(bitPattern: position.ordinal.rawValue)
    }
}

extension Swift.Int {

    @inlinable
    public init?<Tag: ~Copyable & ~Escapable>(exactly position: Tagged<Tag, Ordinal>) {
        self.init(exactly: position.underlying)
    }

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(_ position: Tagged<Tag, Ordinal>) throws(Ordinal.Error)
    {
        self = try Int(position.underlying)
    }

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(bitPattern position: Tagged<Tag, Ordinal>) {
        self = Int(bitPattern: position.underlying)
    }
}

#endif
