//
//  File.swift
//  
//
//  Created by Dylan Elliott on 21/6/2023.
//

import Foundation

public protocol DefaultsKey: RawRepresentable where RawValue == String {
    var store: DefaultsStore { get }
}

public extension DefaultsKey {
    func `get`<T: Codable>() throws -> T {
        try store.value(for: self)
    }
    
    func `set`<T: Codable>(_ value: T) throws {
        try store.set(value, for: self)
    }
}

public extension DefaultsKey {
    func defaultable<T>(_ value: T) -> UserDefaultable<T> {
        .init(wrappedValue: value, key: self)
    }
}
