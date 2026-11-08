extension Swift.RangeReplaceableCollection where Self.Index == Int {

    @inlinable
    public mutating func insert(_ newElement: __owned Element, at i: some Ordinal.`Protocol`) {
        guard let index = Int(exactly: i.ordinal) else {
            preconditionFailure("Collection position is not representable as Int")
        }
        self.insert(newElement, at: index)
    }

    @discardableResult
    @inlinable
    public mutating func remove(at i: some Ordinal.`Protocol`) -> Element {
        guard let index = Int(exactly: i.ordinal) else {
            preconditionFailure("Collection position is not representable as Int")
        }
        return self.remove(at: index)
    }
}
