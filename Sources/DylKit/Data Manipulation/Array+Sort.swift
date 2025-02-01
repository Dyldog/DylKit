//
//  File.swift
//  
//
//  Created by Dylan Elliott on 12/10/2023.
//

import Foundation

public extension Sequence {
    func sorted(by comparator: (Element, Element) -> Bool, ascending: Bool) -> [Element] {
        return self.sorted(by: { (lhs, rhs) in
            if ascending {
                return comparator(lhs, rhs)
            } else {
                return !comparator(lhs, rhs)
            }
        })
    }
    
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
