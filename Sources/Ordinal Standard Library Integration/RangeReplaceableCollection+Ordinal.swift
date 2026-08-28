extension RangeReplaceableCollection where Self.Index == Int {

    @inlinable
    public mutating func insert(_ newElement: __owned Element, at i: some Ordinal.`Protocol`) {
        self.insert(newElement, at: Int(bitPattern: i.ordinal))
    }

    @discardableResult
    @inlinable
    public mutating func remove(at i: some Ordinal.`Protocol`) -> Element {
        self.remove(at: Int(bitPattern: i.ordinal))
    }
}
