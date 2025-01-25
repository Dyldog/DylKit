//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

import UIKit

infix operator ^: AdditionPrecedence

public protocol Funcable { }

public extension Funcable {
    func set<T>(_ keypath: ReferenceWritableKeyPath<Self, T>, _ value: T) -> Self {
        self[keyPath: keypath] = value
        return self
    }
    
    static func ^<T>(lhs: Self, rhs: (keypath: ReferenceWritableKeyPath<Self, T>, value: T)) -> Self {
        lhs.set(rhs.keypath, rhs.value)
    }
}

extension UIView: Funcable { }
