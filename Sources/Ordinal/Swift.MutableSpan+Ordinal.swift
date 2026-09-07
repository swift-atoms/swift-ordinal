public import Cardinal
public import Tagged

extension Swift.MutableSpan where Element: ~Copyable {

    @_lifetime(immortal)
    @inlinable
    public init(
        _unsafeStart start: UnsafeMutablePointer<Element>,
        count: Tagged<Element, Ordinal>.Count
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Span count is not representable as Int")
        }
        let span = unsafe Swift.MutableSpan(
            _unsafeStart: start,
            count: length
        )
        unsafe (self = _overrideLifetime(span, borrowing: ()))
    }
}
