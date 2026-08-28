extension UnsafeRawPointer {

    @inlinable
    public func advanced(by offset: some Ordinal.`Protocol`) -> Self {
        unsafe self.advanced(by: Int(bitPattern: offset.ordinal))
    }

    @inlinable
    public func load<T>(fromByteOffset offset: some Ordinal.`Protocol`, as type: T.Type) -> T {
        unsafe self.load(fromByteOffset: Int(bitPattern: offset.ordinal), as: type)
    }
}
