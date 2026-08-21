extension UnsafeMutablePointer {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Pointee {
        get {
            unsafe self[Int(bitPattern: position.ordinal)]
        }
        nonmutating set {
            unsafe self[Int(bitPattern: position.ordinal)] = newValue
        }
    }
}
