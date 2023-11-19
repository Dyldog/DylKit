//
//  File.swift
//  
//
//  Created by Dylan Elliott on 21/10/2023.
//

import Foundation

public extension Array where Element: Equatable {
    func containsAny(_ others: [Element]) -> Bool {
        self.any { element in
            others.contains(element)
        }
    }
    
    func containsAll(in others: [Element]) -> Bool {
        others.allSatisfy { self.contains($0) }
    }
}
