public import Hash
public import Ordinal_Primitive

extension Ordinal: Hash.`Protocol` {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
