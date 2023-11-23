//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/11/2023.
//

import Foundation

public struct Overridable {
    let defaultValue: String
    let key: ValueKeys
    
    public init(defaultValue: String, key: ValueKeys) {
        self.defaultValue = defaultValue
        self.key = key
    }
    
    public var value: String { UserDefaults.standard.string(forKey: key.rawValue) ?? defaultValue }
    
    public func setValue(_ value: String) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
}
