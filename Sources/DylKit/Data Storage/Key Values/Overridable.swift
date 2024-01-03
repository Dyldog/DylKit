//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/11/2023.
//

import Foundation

public struct Overridable {
    let defaults: UserDefaults = .standard
    let defaultValue: String
    let key: ValueKeys
    
    public init(defaultValue: String, key: ValueKeys) {
        self.defaultValue = defaultValue
        self.key = key
    }
    
    public var value: String { defaults.string(forKey: key.rawValue) ?? defaultValue }
    
    public func setValue(_ value: String) {
        defaults.setValue(value, forKey: key.rawValue)
    }
}
