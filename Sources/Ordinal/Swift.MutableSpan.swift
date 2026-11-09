public import Cardinal
public import Tagged

extension Swift.MutableSpan where Element: ~Copyable {

    @unsafe
    @_lifetime(borrow start)
    @inlinable
    public init(
        _unsafeStart start: UnsafeMutablePointer<Element>,
        count: Tagged<Element, Ordinal>.Count
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Span count is not representable as Int")
        }
        self = unsafe Swift.MutableSpan(
            _unsafeStart: start,
            count: length
        )
    }
}
