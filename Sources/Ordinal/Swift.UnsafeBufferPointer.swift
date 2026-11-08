public import Cardinal
public import Tagged

extension Swift.UnsafeBufferPointer where Element: ~Copyable {

    @inlinable
    public init(
        start: UnsafePointer<Element>?,
        count: Tagged<Element, Ordinal>.Count
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Buffer count is not representable as Int")
        }
        unsafe self.init(start: start, count: length)
    }
}

extension Swift.UnsafeBufferPointer {

    @inlinable
    public subscript(
        _ index: Tagged<Element, Ordinal>
    ) -> Element {
        guard let position = Int(exactly: index.underlying) else {
            preconditionFailure("Buffer position is not representable as Int")
        }
        return unsafe self[position]
    }
}
