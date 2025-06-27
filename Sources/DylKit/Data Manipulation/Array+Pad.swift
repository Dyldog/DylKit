//
//  File.swift
//  
//
//  Created by Dylan Elliott on 24/6/2025.
//

import Foundation

public extension Array {
    func pad(toLength maxLength: Int, with pad: Element) -> Self {
        let padding = maxLength - count
        return padding > 0 ? self + Array(repeating: pad, count: padding) : self
    }
}
