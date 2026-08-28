extension Int {

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
