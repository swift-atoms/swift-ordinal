extension MutableCollection where Self.Index == Int {

    @inlinable
    public mutating func swapAt(_ i: some Ordinal.`Protocol`, _ j: some Ordinal.`Protocol`) {
        self.swapAt(Int(bitPattern: i.ordinal), Int(bitPattern: j.ordinal))
    }
}
