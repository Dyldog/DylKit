//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

import Foundation

public extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
