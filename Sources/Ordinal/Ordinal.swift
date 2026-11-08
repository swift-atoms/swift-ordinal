public import Cardinal
public import Advancement
public import Distance
public import Predecessor
public import Retreat
public import Successor

public struct Ordinal {

    public let rawValue: UInt
}

extension Ordinal: Swift.Sendable {}

extension Ordinal {

    @inlinable
    public init(_ value: UInt) {
        self.rawValue = value
    }

    @inlinable
    public static var zero: Self { Ordinal(UInt.zero) }
}

extension Ordinal {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    @inlinable
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue <= rhs.rawValue
    }

    @inlinable
    public static func > (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue > rhs.rawValue
    }

    @inlinable
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue >= rhs.rawValue
    }
}

extension Ordinal {

    @inlinable
    public init(_ count: Cardinal) {
        self.init(count.rawValue)
    }
}

extension Ordinal {

    @inlinable
    public init?(exactly value: Int) {
        guard value >= 0 else { return nil }
        self.init(UInt(value))
    }

    @inlinable
    public init(_ value: Int) throws(Self.Error) {
        guard value >= 0 else {
            throw .negativeSource(value)
        }
        self.init(UInt(value))
    }
}

extension Ordinal {
    public typealias Advance = Advancement::Advancement
    public typealias Distance = Distance::Distance
    public typealias Predecessor = Predecessor::Predecessor
    public typealias Retreat = Retreat::Retreat
    public typealias Successor = Successor::Successor
}

#if SYNCHRONIZATION_AVAILABLE
    import Synchronization
#endif

extension Ordinal: Swift.CustomStringConvertible {

    public var description: String { rawValue.description }
}

#if SYNCHRONIZATION_AVAILABLE
    import Synchronization
#endif

extension Ordinal: Swift.ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}

#if SYNCHRONIZATION_AVAILABLE
    import Synchronization
#endif

extension Ordinal: Swift.Hashable, Swift.Comparable {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
