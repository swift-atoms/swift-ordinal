extension Swift.ContiguousArray {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Element {
        get {
            guard let index = Int(exactly: position.ordinal) else {
                preconditionFailure("Array position is not representable as Int")
            }
            return self[index]
        }
        set {
            guard let index = Int(exactly: position.ordinal) else {
                preconditionFailure("Array position is not representable as Int")
            }
            self[index] = newValue
        }
    }
}

