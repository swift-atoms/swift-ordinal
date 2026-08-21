public import Cardinal_Primitives
public import Ordinal_Primitive

extension Ordinal {

    @inlinable
    public init(_ count: Cardinal) {
        self.init(count.rawValue)
    }
}
