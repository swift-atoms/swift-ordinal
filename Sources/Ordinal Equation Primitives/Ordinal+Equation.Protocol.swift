// Ordinal+Equation.Protocol.swift
// Conformance of Ordinal to Equation.Protocol — unconditional.
//
// `Equation.Protocol` aliases `Swift.Equatable`; this conformance therefore
// supplies the standard-library conformance directly.

public import Equation_Primitives
public import Ordinal_Primitive

extension Ordinal: Equation.`Protocol` {}
