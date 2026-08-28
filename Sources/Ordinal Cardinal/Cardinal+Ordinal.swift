public import Cardinal
public import Ordinal

extension Cardinal {

    @inlinable
    public init(_ position: Ordinal) {
        self.init(position.rawValue)
    }
}
