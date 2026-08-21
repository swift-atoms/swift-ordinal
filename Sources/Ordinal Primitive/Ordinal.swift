public struct Ordinal {

    public let rawValue: UInt
}

extension Ordinal: Sendable {}

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
