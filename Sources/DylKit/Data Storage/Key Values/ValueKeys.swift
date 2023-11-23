//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/11/2023.
//

import Foundation

public protocol ValueKeys {
    var rawValue: String { get }
    var defaultValue: String { get }
}

public extension ValueKeys {
    var overridable: Overridable {
        .init(defaultValue: defaultValue, key: self)
    }
    
    var value: String { overridable.value }
    
    func setValue(_ value: String) {
        overridable.setValue(value)
    }
}
