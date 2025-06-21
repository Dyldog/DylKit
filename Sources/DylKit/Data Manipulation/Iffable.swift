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
        condition() ? work(self) : self
    }
}

extension Array: Iffable {
    public func mapIf(_ condition: @autoclosure () -> Bool, work: (Element) -> Element) -> Self {
        condition() ? map { work($0) } : self
    }
}
