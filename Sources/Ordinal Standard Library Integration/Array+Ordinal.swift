public import Ordinal
public import Ordinal_Protocol

extension Array {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Element {
        self[Int(bitPattern: position.ordinal)]
    }
}
