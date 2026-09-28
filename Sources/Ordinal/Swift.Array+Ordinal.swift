public import Cardinal
public import Tagged

extension Swift.Array {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable, E: Swift.Error>(
        count: Tagged<Tag, Cardinal>,
        _ element: (Tagged<Tag, Ordinal>) throws(E) -> Element
    ) throws(E) {
        guard let n = try? Int(count.underlying) else {
            preconditionFailure("Array count is not representable as Int")
        }
        self = try (0..<n).map { (index: Int) throws(E) -> Element in
            try element(Tagged<Tag, Ordinal>(Ordinal(UInt(index))))
        }
    }
}

extension Swift.Array {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Element {
        guard let index = Int(exactly: position.ordinal) else {
            preconditionFailure("Array position is not representable as Int")
        }
        return self[index]
    }
}

