//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2023.
//

import Foundation

public extension Array {
    func repeated(_ count: Int) -> Self {
        guard count > 0 else { return self }
        return (0 ..< count).flatMap { _ in self }
    }
}
