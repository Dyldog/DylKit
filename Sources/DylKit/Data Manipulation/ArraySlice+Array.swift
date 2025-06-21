//
//  File.swift
//  
//
//  Created by Dylan Elliott on 8/6/2025.
//

import Foundation

public extension ArraySlice {
    var array: [Element] { Array(self) }
}
