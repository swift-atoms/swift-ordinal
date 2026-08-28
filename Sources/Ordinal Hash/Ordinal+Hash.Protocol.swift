public import Hash_Protocol
public import Ordinal

extension Ordinal::Ordinal: Hash::Hash.`Protocol` {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
