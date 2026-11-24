extension Swift.UInt64 {

    @inlinable
    public init(_ position: some Ordinal.`Protocol`) {
        self = UInt64(position.ordinal.rawValue)
    }
}
