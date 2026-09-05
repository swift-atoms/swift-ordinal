public import Advancement
public import Cardinal
public import Carrier_Protocol

@inlinable
@_disfavoredOverload
public func < <O: Ordinal.`Protocol`, C: Carrier.`Protocol`<Cardinal>>(
    lhs: O,
    rhs: C
) -> Bool where O.Domain == C.Domain {
    lhs.ordinal.rawValue < rhs.cardinal.rawValue
}

@inlinable
@_disfavoredOverload
public func <= <O: Ordinal.`Protocol`, C: Carrier.`Protocol`<Cardinal>>(
    lhs: O,
    rhs: C
) -> Bool where O.Domain == C.Domain {
    lhs.ordinal.rawValue <= rhs.cardinal.rawValue
}

@inlinable
@_disfavoredOverload
public func > <O: Ordinal.`Protocol`, C: Carrier.`Protocol`<Cardinal>>(
    lhs: O,
    rhs: C
) -> Bool where O.Domain == C.Domain {
    lhs.ordinal.rawValue > rhs.cardinal.rawValue
}

@inlinable
@_disfavoredOverload
public func >= <O: Ordinal.`Protocol`, C: Carrier.`Protocol`<Cardinal>>(
    lhs: O,
    rhs: C
) -> Bool where O.Domain == C.Domain {
    lhs.ordinal.rawValue >= rhs.cardinal.rawValue
}

@inlinable
@_disfavoredOverload
public func < <C: Carrier.`Protocol`<Cardinal>, O: Ordinal.`Protocol`>(
    lhs: C,
    rhs: O
) -> Bool where C.Domain == O.Domain {
    lhs.cardinal.rawValue < rhs.ordinal.rawValue
}

@inlinable
@_disfavoredOverload
public func <= <C: Carrier.`Protocol`<Cardinal>, O: Ordinal.`Protocol`>(
    lhs: C,
    rhs: O
) -> Bool where C.Domain == O.Domain {
    lhs.cardinal.rawValue <= rhs.ordinal.rawValue
}

@inlinable
@_disfavoredOverload
public func > <C: Carrier.`Protocol`<Cardinal>, O: Ordinal.`Protocol`>(
    lhs: C,
    rhs: O
) -> Bool where C.Domain == O.Domain {
    lhs.cardinal.rawValue > rhs.ordinal.rawValue
}

@inlinable
@_disfavoredOverload
public func >= <C: Carrier.`Protocol`<Cardinal>, O: Ordinal.`Protocol`>(
    lhs: C,
    rhs: O
) -> Bool where C.Domain == O.Domain {
    lhs.cardinal.rawValue >= rhs.ordinal.rawValue
}

@inlinable
@_disfavoredOverload
public func + <O: Ordinal.`Protocol`, C: Carrier.`Protocol`<Cardinal>>(
    lhs: O,
    rhs: C
) -> O where O.Domain == C.Domain {
    let result = Advancement.reporting(
        lhs.ordinal.rawValue,
        by: rhs.cardinal.rawValue
    )
    precondition(!result.overflow, "Ordinal overflow in advancement")
    return O(Ordinal(result.value))
}

@inlinable
@_disfavoredOverload
public func + <C: Carrier.`Protocol`<Cardinal>, O: Ordinal.`Protocol`>(
    lhs: C,
    rhs: O
) -> O where C.Domain == O.Domain {
    rhs + lhs
}

@inlinable
@_disfavoredOverload
public func += <O: Ordinal.`Protocol`, C: Carrier.`Protocol`<Cardinal>>(
    lhs: inout O,
    rhs: C
) where O.Domain == C.Domain {
    lhs = lhs + rhs
}

@inlinable
@_disfavoredOverload
public func % <O: Ordinal.`Protocol`, C: Carrier.`Protocol`<Cardinal>>(
    lhs: O,
    rhs: C
) -> O where O.Domain == C.Domain {
    O(Ordinal(lhs.ordinal.rawValue % rhs.cardinal.rawValue))
}
