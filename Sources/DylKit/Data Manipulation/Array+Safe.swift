//
//  Array+Safe.swift
//  AppApp
//
//  Created by Dylan Elliott on 21/11/2023.
//

import Foundation

public extension Array {
    subscript(safe index: Index) -> Element? {
        get {
            if self.indices.contains(index) {
                return self[index]
            } else {
                return nil
            }
        }
        set {
            if index <= endIndex, let newValue = newValue {
                self.insert(newValue, at: index)
            }
        }
    }
}
