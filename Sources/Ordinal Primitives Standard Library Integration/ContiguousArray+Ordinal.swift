public import Ordinal_Primitive
public import Ordinal_Protocol_Primitives

extension ContiguousArray {

    @inlinable
    public subscript(_ position: some Ordinal.`Protocol`) -> Element {
        get {
            self[Int(bitPattern: position.ordinal)]
        }
        set {
            self[Int(bitPattern: position.ordinal)] = newValue
        }
    }
}
