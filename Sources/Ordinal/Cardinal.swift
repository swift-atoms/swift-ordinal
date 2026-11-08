public import Cardinal

extension Cardinal {

    @inlinable
    public init(_ position: Ordinal) {
        self.init(position.rawValue)
    }
}
