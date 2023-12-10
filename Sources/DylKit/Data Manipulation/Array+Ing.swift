//
//  Array+Ing.swift
//  AppApp
//
//  Created by Dylan Elliott on 21/11/2023.
//

import Foundation

public extension Array where Index == Int {
    func removing(at index: Int) -> Self {
        var val = self
        val.remove(at: index)
        return val
    }
    
    func inserting(_ value: Element, at index: Int) -> Self {
        var val = self
        val.insert(value, at: index)
        return val
    }
    
    func replacing(_ value: Element, at index: Int) -> Self {
        var val = self
        val[index] = value
        return val
    }
}
