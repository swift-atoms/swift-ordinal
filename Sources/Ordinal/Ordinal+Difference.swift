#if Tagged
public import Advancement
public import Magnitude
public import Cardinal
public import Carrier
public import Difference
public import Distance
public import Retreat
public import Tagged

extension Ordinal {

    @inlinable
    public init(_ difference: Difference) throws(Ordinal.Error) {
        guard difference >= .zero else { throw .underflow }
        self.init(difference.magnitude.value.rawValue)
    }
}

extension Tagged where Underlying == Difference, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init<O: Ordinal.`Protocol`>(_ ordinal: O) where O.Domain == Tag {
        self.init(_unchecked: .positive(Difference.Magnitude(Cardinal(ordinal.ordinal.rawValue))))
    }

    @inlinable
    public init<O: Ordinal.`Protocol`>(fromZero ordinal: O) where O.Domain == Tag {
        self.init(ordinal)
    }
}

@inlinable
public func + <O, D>(lhs: O, rhs: D) throws(Ordinal.Error) -> O
where
    O: Ordinal.`Protocol`,
    D: Carrier.`Protocol`, D.Underlying == Difference,
    O.Domain == D.Domain
{
    if rhs.difference < .zero {
        do {
            return O(
                Ordinal(
                    try Retreat.exact(
                        lhs.ordinal.rawValue,
                        by: rhs.difference.magnitude.value.rawValue
                    )
                )
            )
        } catch {
            throw .underflow
        }
    }
    if rhs.difference == .zero {
        return lhs
    }
    do {
        return O(
            Ordinal(
                try Advancement.exact(
                    lhs.ordinal.rawValue,
                    by: rhs.difference.magnitude.value.rawValue
                )
            )
        )
    } catch {
        throw .overflow
    }
}

@inlinable
public func + <D, O>(lhs: D, rhs: O) throws(Ordinal.Error) -> O
where
    D: Carrier.`Protocol`, D.Underlying == Difference,
    O: Ordinal.`Protocol`,
    D.Domain == O.Domain
{
    try rhs + lhs
}

@inlinable
public func - <O, D>(lhs: O, rhs: D) throws(Ordinal.Error) -> O
where
    O: Ordinal.`Protocol`,
    D: Carrier.`Protocol`, D.Underlying == Difference,
    O.Domain == D.Domain
{
    try lhs + (-rhs)
}

@inlinable
public func - <L, R>(lhs: L, rhs: R) -> L.Offset
where
    L: Ordinal.`Protocol`,
    R: Ordinal.`Protocol`,
    L.Domain == R.Domain
{
    if lhs.ordinal.rawValue >= rhs.ordinal.rawValue {
        let magnitude = Distance.reporting(
            from: rhs.ordinal.rawValue,
            to: lhs.ordinal.rawValue
        ).value
        return L.Offset(
            .positive(Difference.Magnitude(Cardinal(magnitude)))
        )
    }
    let magnitude = Distance.reporting(
        from: lhs.ordinal.rawValue,
        to: rhs.ordinal.rawValue
    ).value
    return L.Offset(
        .negative(Difference.Magnitude(Cardinal(magnitude)))
    )
}

@inlinable
public func += <O, D>(lhs: inout O, rhs: D) throws(Ordinal.Error)
where
    O: Ordinal.`Protocol`,
    D: Carrier.`Protocol`, D.Underlying == Difference,
    O.Domain == D.Domain
{
    lhs = try lhs + rhs
}

@inlinable
public func -= <O, D>(lhs: inout O, rhs: D) throws(Ordinal.Error)
where
    O: Ordinal.`Protocol`,
    D: Carrier.`Protocol`, D.Underlying == Difference,
    O.Domain == D.Domain
{
    lhs = try lhs - rhs
}

#endif
