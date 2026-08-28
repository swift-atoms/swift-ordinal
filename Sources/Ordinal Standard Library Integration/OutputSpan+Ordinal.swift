extension Swift.OutputSpan where Element: ~Copyable {

    @inlinable
    @_lifetime(self: copy self)
    public mutating func swapAt(
        _ i: some Ordinal.`Protocol`,
        _ j: some Ordinal.`Protocol`
    ) {
        swapAt(
            Int(bitPattern: i.ordinal),
            Int(bitPattern: j.ordinal)
        )
    }
}
