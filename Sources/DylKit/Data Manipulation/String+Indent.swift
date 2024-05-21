//
//  File.swift
//  
//
//  Created by Dylan Elliott on 13/2/2024.
//

import Foundation

public extension String {
    func indented(_ indent: Int) -> String {
        components(separatedBy: "\n").map { String(repeating: "\t\t", count: indent) + $0 }.joined(separator: "\n")
    }
}
