public import Advancement
public import Distance
public import Predecessor
public import Retreat
public import Successor

extension Ordinal {
    public typealias Advance = Advancement::Advancement
    public typealias Distance = Distance::Distance
    public typealias Predecessor = Predecessor::Predecessor
    public typealias Retreat = Retreat::Retreat
    public typealias Successor = Successor::Successor
}
