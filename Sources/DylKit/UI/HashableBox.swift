
public struct HashableBox<T>: Hashable {
    
    public let value: T
    public let hash: (T) -> any Hashable
    
    public init(_ value: T, hash: @escaping (T) -> any Hashable) {
        self.value = value
        self.hash = hash
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(hash(value))
    }
    
    public static func == (lhs: HashableBox<T>, rhs: HashableBox<T>) -> Bool {
        lhs.hash(lhs.value).hashValue == rhs.hash(rhs.value).hashValue
    }
}
