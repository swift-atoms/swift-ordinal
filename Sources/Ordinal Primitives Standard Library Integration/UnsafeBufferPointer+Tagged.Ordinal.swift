public import Cardinal_Primitives_Standard_Library_Integration
public import Tagged_Primitives

extension UnsafeBufferPointer where Element: ~Copyable {

    @inlinable
    public init(
        start: UnsafePointer<Element>?,
        count: Tagged<Element, Ordinal>.Count
    ) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}

extension UnsafeBufferPointer {

    @inlinable
    public subscript(
        _ index: Tagged<Element, Ordinal>
    ) -> Element {
        unsafe self[Int(bitPattern: index.underlying)]
    }
}
