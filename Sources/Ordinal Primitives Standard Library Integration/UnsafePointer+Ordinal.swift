extension UnsafePointer {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Pointee {
        unsafe self[Int(bitPattern: position.ordinal)]
    }
}
