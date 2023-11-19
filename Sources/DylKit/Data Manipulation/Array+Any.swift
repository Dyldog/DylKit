//
//  File.swift
//  
//
//  Created by Dylan Elliott on 21/10/2023.
//

import Foundation

public extension Array {
    func any(_ condition: (Element) -> Bool) -> Bool {
        if first(where: { condition($0) }) != nil {
            return true
        } else {
            return false
        }
    }
}
