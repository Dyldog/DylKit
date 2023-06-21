//
//  DefaultsStore.swift
//  
//
//  Created by Dylan Elliott on 21/6/2023.
//

import Foundation

public protocol DefaultsStore {
    func set(data: Data?, for key: any DefaultsKey)
    func data(for key: any DefaultsKey) -> Data?
    @discardableResult func synchronize() -> Bool
}

public enum DefaultsStoreError: Error {
    case dataNotFound
    case failedToEncode
}

public extension DefaultsStore {
    func set<T: Codable>(_ value: T?, for key: any DefaultsKey) throws {
        let data = try JSONEncoder().encode(value)
        set(data: data, for: key)
        synchronize()
    }
    
    func value<T: Codable>(for key: any DefaultsKey) throws -> T {
        guard let data = data(for: key) else { throw DefaultsStoreError.dataNotFound }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

public extension DefaultsStore {
    func overwriteAllValues<T: DefaultsKey>(of keyType: T.Type) {
        T.allCases.forEach {
            overwriteValues(for: $0)
        }
    }
    
    func overwriteValues(for key: any DefaultsKey) {
        if let data = data(for: key) {
            set(data: data, for: key)
        }
    }
}
