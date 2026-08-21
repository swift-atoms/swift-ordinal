public import Cardinal_Primitives_Standard_Library_Integration
public import Tagged_Primitives

extension Swift.Span where Element: ~Copyable {

    @_lifetime(immortal)
    @inlinable
    public init(
        _unsafeStart start: UnsafePointer<Element>,
        count: Tagged<Element, Ordinal>.Count
    ) {
        let span = unsafe Swift.Span(
            _unsafeStart: start,
            count: Int(bitPattern: count.underlying)
        )
        unsafe (self = _overrideLifetime(span, borrowing: ()))
    }
}
