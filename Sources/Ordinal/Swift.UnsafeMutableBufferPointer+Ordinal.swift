public import Cardinal
public import Tagged

extension Swift.UnsafeMutableBufferPointer where Element: ~Copyable {

    @inlinable
    public init(
        start: UnsafeMutablePointer<Element>?,
        count: Tagged<Element, Ordinal>.Count
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Buffer count is not representable as Int")
        }
        unsafe self.init(start: start, count: length)
    }
}

extension Swift.UnsafeMutableBufferPointer {

    @inlinable
    public subscript(
        _ index: Tagged<Element, Ordinal>
    ) -> Element {
        get {
            guard let position = Int(exactly: index.underlying) else {
                preconditionFailure("Buffer position is not representable as Int")
            }
            return unsafe self[position]
        }
        nonmutating set {
            guard let position = Int(exactly: index.underlying) else {
                preconditionFailure("Buffer position is not representable as Int")
            }
            unsafe self[position] = newValue
        }
    }
}
