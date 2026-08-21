public import Cardinal_Primitives
public import Ordinal_Primitive

extension Cardinal {

    @inlinable
    public init(_ position: Ordinal) {
        self.init(position.rawValue)
    }
}
