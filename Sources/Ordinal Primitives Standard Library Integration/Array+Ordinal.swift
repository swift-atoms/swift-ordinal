public import Ordinal_Primitive
public import Ordinal_Protocol_Primitives

extension Array {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Element {
        self[Int(bitPattern: position.ordinal)]
    }
}
