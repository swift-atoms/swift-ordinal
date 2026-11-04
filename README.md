# swift-ordinal

Use this package when you need a zero-based position that can't be negative and must not be mixed up with a count or an offset. Start from `Ordinal`, wrap it in a `Tagged` type to keep positions in different domains apart, or conform your own type to `Ordinal.Protocol`. For a count rather than a position, use `Cardinal` from swift-cardinal.

## Laws

- `Ordinal` holds a `UInt`. Position n converts to the count n and back, unchanged.
- Adding a count with `+` traps on overflow. `Ordinal.advance.exact(by:)` throws an overflow error instead, and `Ordinal.advance.saturating(by:)` stops at the largest position.
- `Ordinal.advance.clamped(by:to:)` returns the bound whenever the result would pass it, even when the bound lies behind the starting position. `Ordinal.retreat.clamped(by:to:)` likewise returns the bound whenever the bound is not behind the starting position.
- `Ordinal.successor.exact()` throws at the largest position and `Ordinal.predecessor.exact()` throws at zero. Their saturating forms stay where they are.
- `Ordinal.distance.forward(to:)` throws when the target is behind the start. `Ordinal.distance.unchecked(to:)` traps in that case.
- Subtracting one position from another gives a signed offset and works across the whole `UInt` range. Adding a signed offset throws an underflow error below zero and an overflow error above the largest position.
- `%` traps when the count is zero.
- `Atomic.advance(within:)` returns the current position and stores the next one, wrapping to zero at the capacity.
- A range of positions has the distance between its bounds as its count. `Swift.Range.init(start:count:)` traps when the end would overflow.
- Converting to `Int` throws, or returns nil for the failable form, above `Int.max`. The `bitPattern:` form wraps. Converting from a negative `Int` throws or returns nil.
- The standard library subscripts, pointer offsets and collection operations that take a position trap when it is above `Int.max`, rather than reading it as a negative index.
