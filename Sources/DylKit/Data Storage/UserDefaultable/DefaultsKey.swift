//
//  File.swift
//  
//
//  Created by Dylan Elliott on 21/6/2023.
//

import Foundation

public protocol DefaultsKey: RawRepresentable where RawValue == String { }

public extension DefaultsKey {
    func `get`<T: Codable>(from store: DefaultsStore = UserDefaults.standard) throws -> T {
        try store.value(for: self)
    }
    
    func `set`<T: Codable>(_ value: T, in store: DefaultsStore = UserDefaults.standard) throws {
        try store.set(value, for: self)
    }
}
