extension Swift.UnsafeRawPointer {

    @inlinable
    public func advanced(by offset: some Ordinal.`Protocol`) -> Self {
        guard let distance = Int(exactly: offset.ordinal) else {
            preconditionFailure("Byte offset is not representable as Int")
        }
        return unsafe self.advanced(by: distance)
    }

    @inlinable
    public func load<T>(fromByteOffset offset: some Ordinal.`Protocol`, as type: T.Type) -> T {
        guard let distance = Int(exactly: offset.ordinal) else {
            preconditionFailure("Byte offset is not representable as Int")
        }
        return unsafe self.load(fromByteOffset: distance, as: type)
    }
}

