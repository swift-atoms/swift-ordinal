public import Cardinal

extension Ordinal {

    @inlinable
    public init(_ count: Cardinal) {
        self.init(count.rawValue)
    }
}
