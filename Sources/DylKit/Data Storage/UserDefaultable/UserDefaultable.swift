//
//  File.swift
//  
//
//  Created by Dylan Elliott on 21/6/2023.
//

import Foundation

struct StringDefaultsKey: DefaultsKey, RawRepresentable {
    let value: String
    var rawValue: String { value }
    let store: DefaultsStore
    
    init(rawValue: String, store: DefaultsStore) {
        self.value = rawValue
        self.store = store
    }
    
    init(rawValue: String) {
        self.init(rawValue: rawValue, store: UserDefaults.standard)
    }
}

@propertyWrapper
public struct UserDefaultable<T: Codable> {
    
    let key: any DefaultsKey
    let initial: T
    
    var store: DefaultsStore { key.store }
    public var wrappedValue: T {
        get {
            do {
                if let data = store.data(for: key) {
                    return try JSONDecoder().decode(T.self, from: data)
                } 
            } catch {
                print(error)
            }
            
            return initial
        }
        set {
            self.setValue(newValue)
            forceUpdate()
        }
    }
    
    public func setValue(_ newValue: T) {
        guard let data = try? JSONEncoder().encode(newValue) else { return }
        
        // JSONEncoder turns `nil` into the string `"null"`. It makes it look like there's a
        // value when there shouldn't be one
        if String(data: data, encoding: .utf8) == "null" {
            store.set(data: nil, for: key)
        } else {
            store.set(data: data, for: key)
        }
    }
    
    public init(wrappedValue: T, key: any DefaultsKey) {
        self.key = key
        self.initial = wrappedValue
    }
    
    public init(wrappedValue: T, key: String) {
        self.key = StringDefaultsKey(rawValue: key)
        self.initial = wrappedValue
    }
    
    // HACK: SwiftUI updates don't get triggered when we set a new value (because we're only updating
    // the user defaults value, no memory is changing), so we need to update a dummy value to trigger
    // a refresh
    private var updater: Bool = false
    mutating private func forceUpdate() {
        updater.toggle()
    }
}

public extension UserDefaultable where T: RangeReplaceableCollection {
    func append(_ element: T.Element) {
        setValue(wrappedValue + [element])
    }
}
