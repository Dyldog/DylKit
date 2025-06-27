//
//  File.swift
//  
//
//  Created by Dylan Elliott on 24/6/2025.
//

import Foundation

public extension Array where Element: Hashable {
    var uniqueCount: [Element: Int] {
        Dictionary(grouping: self, by: { $0 }).mapValues { items in items.count }
    }
}
