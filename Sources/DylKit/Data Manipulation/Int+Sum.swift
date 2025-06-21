//
//  File.swift
//  
//
//  Created by Dylan Elliott on 13/6/2025.
//

import Foundation

public extension [Int] {
    func sum() -> Int {
        reduce(0, +)
    }
}
