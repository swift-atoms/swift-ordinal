// Ordinal+Hash.Protocol.swift
// Conformance of Ordinal to Hash.Protocol — unconditional.
//
// `Hash.Protocol` refines `Swift.Hashable`, so this conformance also supplies
// the standard-library conformance.
//
// The explicit `hash(into:)` is required (rather than relying on synthesis)
// because Hashable synthesis only fires when the conformance is declared in
// the same file as the type. The single-property hash collapses to a single
// `combine` over `rawValue`.

public import Hash_Primitives
public import Ordinal_Primitive

extension Ordinal: Hash.`Protocol` {
    /// Feeds the underlying value into the given hasher.
    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
