//
//  File.swift
//  
//
//  Created by Dylan Elliott on 19/11/2023.
//

import Foundation

public protocol Iffable { }

public extension Iffable {
    func `if`(_ condition: @autoclosure () -> Bool, work: (Self) -> Self) -> Self {
        if condition() {
            work(self)
        } else {
            self
        }
    }
}

extension Array: Iffable { }
