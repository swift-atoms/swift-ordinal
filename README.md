# Ordinal

A discrete position with domain-preserving Count and Offset types. The package
has exactly two runtime modules:

- `Ordinal`: the value, errors, `Ordinal.Protocol`, Carrier/Tagged operations,
  difference-based movement, and exact/saturating/clamped policies.
- `Ordinal_Standard_Library_Integration`: collection, pointer, span, and machine
  integer integration; reexports `Ordinal`.

```swift
import Ordinal
import Difference

let start = Ordinal(3 as UInt)
let end = Ordinal(8 as UInt)
let offset: Difference = end - start
let moved = try start + offset
```

`Ordinal.Protocol.Count` and `.Offset` must carry the same Domain as the position.
Subtraction returns the left position's associated Offset. With Tagged positions,
this derives the result tag from the operands instead of the expected return type.
Movement rejects overflow/underflow; full-range ordinal subtraction is exact.

The former smaller runtime modules and public Test Support product have been
removed. Import the domain module directly. Package dependencies retain URLs; the arithmetic workspace resolves local packages.

Operation identities come from Successor, Predecessor, Advancement, Retreat, and Distance. The canonical implementations operate on `Ordinal.Protocol`, retaining the associated Count and Offset domains without separate Tagged implementations.
