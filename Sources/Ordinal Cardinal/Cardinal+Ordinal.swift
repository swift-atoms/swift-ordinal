public import Cardinal
public import Ordinal_Primitive

extension Cardinal {

    @inlinable
    public init(_ position: Ordinal) {
        self.init(position.rawValue)
    }
}
