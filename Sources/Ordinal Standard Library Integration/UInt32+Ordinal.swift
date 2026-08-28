extension UInt32 {

    @inlinable
    public init(_ position: some Ordinal.`Protocol`) {
        self = UInt32(position.ordinal.rawValue)
    }
}
