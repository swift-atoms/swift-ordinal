public import Cardinal_Primitives_Standard_Library_Integration
public import Tagged_Primitives

extension UnsafeMutableBufferPointer where Element: ~Copyable {

    @inlinable
    public init(
        start: UnsafeMutablePointer<Element>?,
        count: Tagged<Element, Ordinal>.Count
    ) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}

extension UnsafeMutableBufferPointer {

    @inlinable
    public subscript(
        _ index: Tagged<Element, Ordinal>
    ) -> Element {
        get {
            unsafe self[Int(bitPattern: index.underlying)]
        }
        nonmutating set {
            unsafe self[Int(bitPattern: index.underlying)] = newValue
        }
    }
}
