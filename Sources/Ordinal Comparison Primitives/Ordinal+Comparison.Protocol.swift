// Ordinal+Comparison.Protocol.swift
// Conformance of Ordinal to Comparison.Protocol — unconditional.
//
// `Comparison.Protocol` aliases `Swift.Comparable`; this conformance therefore
// supplies the standard-library conformance directly.

public import Comparison_Primitives
public import Ordinal_Primitive

extension Ordinal: Comparison.`Protocol` {}
