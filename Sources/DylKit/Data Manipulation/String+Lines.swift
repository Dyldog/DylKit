//
//  File.swift
//  
//
//  Created by Dylan Elliott on 8/6/2025.
//

import Foundation

public extension String {
    var lines: [String] { components(separatedBy: "\n") }
    
    var nonEmptyLines: [String] {
        lines.filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false }
    }
}
