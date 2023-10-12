//
//  File.swift
//  
//
//  Created by Dylan Elliott on 12/10/2023.
//

import Foundation

public extension Array {
    func sorted<T: Comparable>(by keypath: KeyPath<Element, T>, ascending: Bool) -> [Element] {
        return self.sorted(by: { (lhs, rhs) in
            if ascending {
                return lhs[keyPath: keypath] < rhs[keyPath: keypath]
            } else {
                return lhs[keyPath: keypath] > rhs[keyPath: keypath]
            }
        })
    }
}
