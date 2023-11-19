//
//  File.swift
//  
//
//  Created by Dylan Elliott on 20/10/2023.
//

import Foundation

public extension Array where Element: Equatable {
    mutating func toggleMembership(of value: Element) {
        if contains(value) {
            removeAll(where: { $0 == value })
        } else {
            append(value)
        }
    }
}
