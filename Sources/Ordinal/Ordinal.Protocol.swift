#if Tagged
public import Advancement
public import Cardinal
public import Carrier
public import Difference
public import Tagged

extension Ordinal {

    public protocol `Protocol` {

        associatedtype Domain: ~Copyable & ~Escapable

        associatedtype Count: Carrier.`Protocol`<Cardinal>
        where Count.Domain == Domain

        associatedtype Offset: Carrier.`Protocol`<Difference> = Tagged<Domain, Difference>
        where Offset.Domain == Domain

        var ordinal: Ordinal { get }

        init(_ ordinal: Ordinal)
    }
}

extension Ordinal: Ordinal.`Protocol` {

    public typealias Domain = Never

    public typealias Count = Cardinal

    public typealias Offset = Difference

    @inlinable
    public var ordinal: Ordinal { self }

    @inlinable
    public init(_ ordinal: Ordinal) {
        self = ordinal
    }
}

extension Tagged: Ordinal.`Protocol`
where Underlying: Ordinal.`Protocol`, Tag: ~Copyable & ~Escapable {

    public typealias Domain = Tag

    public typealias Count = Tagged<Tag, Cardinal>

    public typealias Offset = Tagged<Tag, Difference>

    @inlinable
    public var ordinal: Ordinal { underlying.ordinal }

    @_disfavoredOverload
    @inlinable
    public init(_ ordinal: Ordinal) {
        self.init(_unchecked: Underlying(ordinal))
    }
}

extension Ordinal.`Protocol` {

    @inlinable
    public static func + (lhs: Self, rhs: Count) -> Self {
        let result = Advancement.reporting(
            lhs.ordinal.rawValue,
            by: rhs.cardinal.rawValue
        )
        precondition(!result.overflow, "Ordinal overflow in advancement")
        return Self(Ordinal(result.value))
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Count) {
        lhs = lhs + rhs
    }
}

#endif
