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
    
    init(rawValue: String) {
        self.value = rawValue
    }
}

@propertyWrapper
public struct UserDefaultable<T: Codable> {
    
    let key: any DefaultsKey
    let initial: T
    let store: DefaultsStore
    
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
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            
            // JSONEncoder turns `nil` into the string `"null"`. It makes it look like there's a
            // value when there shouldn't be one
            if String(data: data, encoding: .utf8) == "null" {
                store.set(data: nil, for: key)
            } else {
                store.set(data: data, for: key)
            }
            forceUpdate()
        }
    }
    
    public init(wrappedValue: T, key: any DefaultsKey, store: DefaultsStore = UserDefaults.standard) {
        self.key = key
        self.initial = wrappedValue
        self.store = store
    }
    
    public init(wrappedValue: T, key: String, store: DefaultsStore = UserDefaults.standard) {
        self.key = StringDefaultsKey(rawValue: key)
        self.initial = wrappedValue
        self.store = store
    }
    
    // HACK: SwiftUI updates don't get triggered when we set a new value (because we're only updating
    // the user defaults value, no memory is changing), so we need to update a dummy value to trigger
    // a refresh
    private var updater: Bool = false
    mutating private func forceUpdate() {
        updater.toggle()
    }
}
