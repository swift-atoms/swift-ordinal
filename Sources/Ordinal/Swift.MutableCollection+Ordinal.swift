extension Swift.MutableCollection where Self.Index == Int {

    @inlinable
    public mutating func swapAt(_ i: some Ordinal.`Protocol`, _ j: some Ordinal.`Protocol`) {
        guard let first = Int(exactly: i.ordinal), let second = Int(exactly: j.ordinal) else {
            preconditionFailure("Collection position is not representable as Int")
        }
        self.swapAt(first, second)
    }
}

