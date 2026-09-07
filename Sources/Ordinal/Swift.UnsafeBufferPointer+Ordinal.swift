public import Cardinal
public import Tagged

extension Swift.UnsafeBufferPointer where Element: ~Copyable {

    @inlinable
    public init(
        start: UnsafePointer<Element>?,
        count: Tagged<Element, Ordinal>.Count
    ) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}

extension Swift.UnsafeBufferPointer {

    @inlinable
    public subscript(
        _ index: Tagged<Element, Ordinal>
    ) -> Element {
        unsafe self[Int(bitPattern: index.underlying)]
    }
}
