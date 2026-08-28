public import Cardinal
public import Ordinal

extension Ordinal {

    @inlinable
    public init(_ count: Cardinal) {
        self.init(count.rawValue)
    }
}
