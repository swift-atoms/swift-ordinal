#if Tagged
public import Cardinal
public import Tagged

extension Swift.Span where Element: ~Copyable {

    @_lifetime(immortal)
    @inlinable
    public init(
        _unsafeStart start: UnsafePointer<Element>,
        count: Tagged<Element, Ordinal>.Count
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Span count is not representable as Int")
        }
        let span = unsafe Swift.Span(
            _unsafeStart: start,
            count: length
        )
        unsafe (self = _overrideLifetime(span, borrowing: ()))
    }
}

#endif
