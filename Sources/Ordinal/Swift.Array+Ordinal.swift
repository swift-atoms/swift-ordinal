public import Cardinal
public import Tagged

extension Swift.Array {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable, E: Swift.Error>(
        count: Tagged<Tag, Cardinal>,
        _ element: (Tagged<Tag, Ordinal>) throws(E) -> Element
    ) throws(E) {
        let n = Int(bitPattern: count.underlying)
        self = try (0..<n).map { (index: Int) throws(E) -> Element in
            try element(Tagged<Tag, Ordinal>(Ordinal(UInt(index))))
        }
    }
}

extension Swift.Array {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Element {
        self[Int(bitPattern: position.ordinal)]
    }
}
