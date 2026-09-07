public import Cardinal
public import Tagged

extension Swift.UnsafeMutableBufferPointer where Element: ~Copyable {

    @inlinable
    public init(
        start: UnsafeMutablePointer<Element>?,
        count: Tagged<Element, Ordinal>.Count
    ) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}

extension Swift.UnsafeMutableBufferPointer {

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
