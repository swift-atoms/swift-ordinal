public import Cardinal
public import Cardinal_Carrier
public import Carrier_Protocol
public import Ordinal
public import Tagged

extension Ordinal {

    public protocol `Protocol` {

        associatedtype Domain: ~Copyable & ~Escapable

        associatedtype Count: Carrier.`Protocol`<Cardinal>

        var ordinal: Ordinal { get }

        init(_ ordinal: Ordinal)
    }
}

extension Ordinal: Ordinal.`Protocol` {

    public typealias Domain = Never

    public typealias Count = Cardinal

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
        Self(Ordinal(lhs.ordinal.rawValue + rhs.cardinal.rawValue))
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Count) {
        lhs = lhs + rhs
    }
}
