#if Tagged
extension Swift.OutputSpan where Element: ~Copyable {

    @inlinable
    @_lifetime(self: copy self)
    public mutating func swapAt(
        _ i: some Ordinal.`Protocol`,
        _ j: some Ordinal.`Protocol`
    ) {
        guard let first = Int(exactly: i.ordinal), let second = Int(exactly: j.ordinal) else {
            preconditionFailure("Span position is not representable as Int")
        }
        swapAt(first, second)
    }
}

#endif
